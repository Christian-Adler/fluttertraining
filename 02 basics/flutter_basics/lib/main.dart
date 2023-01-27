import 'package:flutter/material.dart';
import 'package:flutter_basics/quiz.dart';
import 'package:flutter_basics/result.dart';

import 'GradientAppBar.dart';

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
  var _totalScore = 0;
  var _questionIdx = 0;
  static const _questions = [
    {
      'questionText': 'What\'s your favorite color?',
      'answers': [
        {'text': 'Black', 'score': 10},
        {'text': 'Red', 'score': 5},
        {'text': 'Green', 'score': 3},
        {'text': 'White', 'score': 1},
      ],
    },
    {
      'questionText': 'What\'s your favorite animal?',
      'answers': [
        {'text': 'Rabbit', 'score': 3},
        {'text': 'Snake', 'score': 11},
        {'text': 'Elephant', 'score': 5},
        {'text': 'Lion', 'score': 9},
      ],
    },
    {
      'questionText': 'Who\'s your favorite instructor?',
      'answers': [
        {'text': 'Max', 'score': 1},
        {'text': 'Max', 'score': 1},
        {'text': 'Max', 'score': 1},
        {'text': 'Max', 'score': 1},
      ],
    },
  ];

  void _answerQuestion(int score) {
    print('Answer');
    setState(() {
      _totalScore += score;
      _questionIdx++;
      // if (_questionIdx % questions.length == 0) _questionIdx = 0;
    });
  }

  void _resetQuiz() {
    setState(() {
      _totalScore = 0;
      _questionIdx = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: GradientAppBar(
          title: Text('My first App'),
          gradientColors: [
            Color(0xff027dfd),
            Color(0xff4100e0),
          ],
        ),
        body: _questionIdx < _questions.length
            ? Quiz(
          questions: _questions,
          answerQuestion: _answerQuestion,
          questionIdx: _questionIdx,
        )
            : Result(
          resultText: 'FINISHED',
          resultScore: _totalScore,
          resetHandler: _resetQuiz,
        ),
      ),
    );
  }
}
