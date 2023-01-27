import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// Function with only one expression:
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  var questionIdx = 0;

  void answerQuestion() {
    print('Answer');
    setState(() {
      questionIdx++;
      if (questionIdx >= 2) questionIdx = 0;
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
            Text(questions[questionIdx]),
            ElevatedButton(onPressed: answerQuestion, child: Text('Answer 1')),
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
