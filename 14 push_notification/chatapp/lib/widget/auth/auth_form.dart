import 'dart:io';

import 'package:chatapp/pickers/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(String email, String username, String password, File? image, bool isLoginMode) submitFn;
  final bool isLoading;

  const AuthForm(this.submitFn, this.isLoading, {Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  var _isLoginMode = true;

  final _formKey = GlobalKey<FormState>();
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';
  File? _userImage;

  void _pickedImageHandler(File image) {
    _userImage = image;
  }

  void _trySubmit() {
    var currentState = _formKey.currentState;
    if (currentState == null) return;

    final isValid = currentState.validate();
    FocusScope.of(context).unfocus();

    if (_userImage == null && !_isLoginMode) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please pick an image'),
          duration: const Duration(seconds: 2),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }

    if (isValid) {
      currentState.save();

      widget.submitFn(_userEmail, _userName, _userPassword, _userImage, _isLoginMode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_isLoginMode) UserImagePicker(imagePickFn: _pickedImageHandler),
                  TextFormField(
                    key: const ValueKey('email'),
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: 'Email address'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _userEmail = newValue?.trim() ?? '';
                    },
                  ),
                  if (!_isLoginMode)
                    TextFormField(
                      key: const ValueKey('user'),
                      decoration: const InputDecoration(labelText: 'Username'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty || value.trim().length < 4) {
                          return 'Please enter at least 4 characters';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _userName = newValue?.trim() ?? '';
                      },
                    ),
                  TextFormField(
                    key: const ValueKey('password'),
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Password'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty || value.trim().length < 7) {
                        return 'Please enter a valid password (len > 6)';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _userPassword = newValue?.trim() ?? '';
                    },
                  ),
                  const SizedBox(height: 12),
                  if (widget.isLoading) const CircularProgressIndicator(),
                  if (!widget.isLoading)
                    ElevatedButton(
                      onPressed: _trySubmit,
                      child: Text(_isLoginMode ? 'Login' : 'Sign up'),
                    ),
                  if (!widget.isLoading)
                    TextButton(
                        onPressed: () {
                          setState(() {
                            _isLoginMode = !_isLoginMode;
                          });
                        },
                        child: Text(_isLoginMode ? 'Create new account' : 'I already have an account'))
                ],
              )),
        ),
      ),
    );
  }
}
