import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/http_exception.dart';

import '../models/globals.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

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

  void logout() {
    _token = null;
    _userId = null;
    _expiryDate = null;
    notifyListeners();
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

      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }
}
