import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// Function with only one expression:
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My first App'),
          backgroundColor: Color.fromRGBO(102, 0, 255, 1.0),
        ),
        body: Text('body text'),
      ),
    );
  }
}
