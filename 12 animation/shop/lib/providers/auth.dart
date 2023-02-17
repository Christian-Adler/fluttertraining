import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/models/http_exception.dart';

import '../models/globals.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  Timer? _authTimer;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_token != null && _expiryDate != null && _expiryDate!.isAfter(DateTime.now())) return _token;
    return null;
  }

  String? get userId {
    return _userId;
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate('/v1/accounts:signUp', email, password);
  }

  Future<void> signIn(String email, String password) async {
    return _authenticate('/v1/accounts:signInWithPassword', email, password);
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) return false;
    final extractedUserData = jsonDecode(prefs.getString('userData')!) as Map<String, dynamic>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);
    if (expiryDate.isBefore(DateTime.now())) return false;

    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiryDate = expiryDate;

    notifyListeners();

    _autoLogout();

    return true;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();
    _token = null;
    _userId = null;
    _expiryDate = null;
    _authTimer?.cancel();
    _authTimer = null;
    notifyListeners();
  }

  void _autoLogout() {
    if (_expiryDate == null) return;
    _authTimer?.cancel();
    final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }

  Future<void> _authenticate(String urlPath, String email, String password) async {
    final url = Uri.https(Globals.apiURL, urlPath, {'key': Globals.apiKey});
    try {
      final response = await http.post(url,
          body: jsonEncode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));

      var decodedResponse = jsonDecode(response.body);
      if (decodedResponse['error'] != null) {
        throw HttpException(decodedResponse['error']['message']);
      }

      _token = decodedResponse['idToken'];
      _userId = decodedResponse['localId'];
      _expiryDate = DateTime.now().add(Duration(seconds: int.parse(decodedResponse['expiresIn'])));
      _autoLogout();

      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final userData = jsonEncode({'token': _token, 'userId': _userId, 'expiryDate': _expiryDate!.toIso8601String()});
      prefs.setString("userData", userData);
    } catch (err) {
      rethrow;
    }
  }
}
