import 'package:flutter/material.dart';

import './question.dart';

// void main() {
//   runApp(MyApp());
// }

// Function with only one expression:
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _questionIdx = 0;

  void _answerQuestion() {
    print('Answer');
    setState(() {
      _questionIdx++;
      if (_questionIdx >= 2) _questionIdx = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    var questions = ['What\'s your favorite color?', 'Favorite animal?'];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My first App'),
          backgroundColor: Color.fromRGBO(102, 0, 255, 1.0),
        ),
        body: Column(
          children: <Widget>[
            Question(questions[_questionIdx]),
            ElevatedButton(onPressed: _answerQuestion, child: Text('Answer 1')),
            ElevatedButton(
                onPressed: () => print('answer 2'), child: Text('Answer 2')),
            ElevatedButton(
                onPressed: () {
                  print('Answer 3');
                },
                child: Text('Answer 3')),
          ],
        ),
      ),
    );
  }
}
