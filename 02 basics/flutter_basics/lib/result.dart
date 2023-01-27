import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final String resultText;
  final int resultScore;
  final VoidCallback resetHandler;

  const Result({
    @required this.resultText,
    @required this.resultScore,
    @required this.resetHandler,
  });

  String get resultPhrase {
    String resultText = 'You did it';
    if (resultScore <= 8)
      resultText = 'You are awesome!';
    else if (resultScore <= 12) resultText = 'Pretty likeable';
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Text(
          resultPhrase,
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        ElevatedButton(onPressed: resetHandler, child: Text('reset')),
      ],
    ));
  }
}
