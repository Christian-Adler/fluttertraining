import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// Function with only one expression:
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  void answerQuestion() {
    print('Answer');
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
            Text('the question'),
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
