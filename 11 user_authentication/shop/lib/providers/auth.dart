import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/globals.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  Future<void> signUp(String email, String password) async {
    return _authenticate('/v1/accounts:signUp', email, password);
  }

  Future<void> signIn(String email, String password) async {
    return _authenticate('/v1/accounts:signInWithPassword', email, password);
  }

  Future<void> _authenticate(String urlPath, String email, String password) async {
    final url = Uri.https(Globals.apiURL, urlPath, {'key': Globals.apiKey});
    final response = await http.post(url,
        body: jsonEncode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }));

    var decodedResponse = jsonDecode(response.body);
    print(decodedResponse);
  }
}
