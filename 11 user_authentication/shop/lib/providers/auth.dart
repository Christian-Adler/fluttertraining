import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  Future<void> signup(String email, String password) async {
    const apiKey = 'AIzaSyDaiq-x0sPELvAOUeBc4WIoRaRHm0Sn6DQ';
    final url = Uri.https('identitytoolkit.googleapis.com', '/v1/accounts:signUp', {'key': apiKey});
    final response = await http.post(url,
        body: jsonEncode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }));
    print(response
        .body); // {error: {code: 400, message: MISSING_PASSWORD, errors: [{message: MISSING_PASSWORD, domain: global, reason: invalid}]}}
    var signupResponse = jsonDecode(response.body);
    print(signupResponse);
  }
}
