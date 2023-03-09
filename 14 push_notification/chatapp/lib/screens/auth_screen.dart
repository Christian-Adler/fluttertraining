import 'dart:io';

import 'package:chatapp/widget/auth/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(String email, String username, String password, File? userImage, bool isLoginMode) async {
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLoginMode) {
        authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      } else {
        if (userImage == null) throw Exception('No user image set');
        authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);

        // image upload
        var ref = FirebaseStorage.instance.ref('user_image').child('${authResult.user?.uid ?? 'invalid'}.jpg');
        var uploadTask = ref.putFile(userImage);
        uploadTask.whenComplete(() async {
          var url = await ref.getDownloadURL();


          await FirebaseFirestore.instance
              .collection('users')
              .doc(authResult.user?.uid)
              .set({'username': username, 'email': email, 'imageUrl': url});
        });
      }
    } catch (err) {
      var message = err.toString();
      if (err is PlatformException) {
        message = err.message ?? '';
      }

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 2),
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .error,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .primary,
      body: AuthForm(_submitAuthForm, _isLoading),
    );
  }
}
