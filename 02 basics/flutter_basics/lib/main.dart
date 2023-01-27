import 'package:flutter/material.dart';
import 'package:flutter_basics/answer.dart';

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
  var questions = [
    {
      'questionText': 'What\'s your favorite color?',
      'answers': ['Black', 'Red', 'Green', 'Blue']
    },
    {
      'questionText': 'What\'s your favorite animal?',
      'answers': ['Rabbit', 'Snake', 'Dog']
    },
    {
      'questionText': 'What\'s your favorite isntructor?',
      'answers': ['Max', 'Me']
    },
  ];

  void _answerQuestion() {
    print('Answer');
    setState(() {
      _questionIdx++;
      if (_questionIdx % questions.length == 0)
        _questionIdx = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My first App'),
          // backgroundColor: Color.fromRGBO(102, 0, 255, 1.0),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                // begin: Alignment.topCenter,
                // end: Alignment.bottomCenter,
                  colors: <Color>[
                    Color(0xff027dfd),
                    Color(0xff4100e0),
                  ]),
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Question(
              questions[_questionIdx]['questionText'],
            ),
            ...(questions[_questionIdx]['answers'] as List<String>)
                .map((answer) {
              return Answer(_answerQuestion, answer);
            }).toList(),
          ],
        ),
      ),
    );
  }
}
