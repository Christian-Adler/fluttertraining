import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  var _isLoginMode = true;

  final _formKey = GlobalKey<FormState>();
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';

  void _trySubmit() {
    var currentState = _formKey.currentState;
    if (currentState == null) return;

    final isValid = currentState.validate();

    FocusScope.of(context).unfocus();

    if (isValid) {
      currentState.save();

      // TODO send auth request
      print(_userName);
      print(_userEmail);
      print(_userPassword);
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
                  TextFormField(
                    key: const ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: 'Email address'),
                    validator: (value) {
                      if (value == null || value.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _userEmail = newValue ?? '';
                    },
                  ),
                  if (!_isLoginMode)
                    TextFormField(
                      key: const ValueKey('user'),
                      decoration: const InputDecoration(labelText: 'Username'),
                      validator: (value) {
                        if (value == null || value.isEmpty || value.length < 4) {
                          return 'Please enter at least 4 characters';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _userName = newValue ?? '';
                      },
                    ),
                  TextFormField(
                    key: const ValueKey('password'),
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Password'),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 7) {
                        return 'Please enter a valid password (len > 6)';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _userPassword = newValue ?? '';
                    },
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _trySubmit,
                    child: Text(_isLoginMode ? 'Login' : 'Sign up'),
                  ),
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
