// 1) Create a new Flutter App (in this project) and output an AppBar and some text
// below it
// 2) Add a button which changes the text (to any other text of your choice)
// 3) Split the app into three widgets: App, TextControl & Text

import 'package:flutter/material.dart';
import 'package:flutter_course/ClickCounterResult.dart';
import 'package:flutter_course/CounterButton.dart';

void main() => runApp(MainApp());

class MainApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainAppState();
  }
}

class _MainAppState extends State<MainApp> {
  String _text = 'Text in body';
  int _counter = 0;

  void _buttonPressedHandler() {
    setState(() {
      _counter++;
      _text = 'ButtonPressed x ' + _counter.toString() + ' times';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Assignment Problem')),
        body: Column(
          children: [
            ClickCounterResult(counter: _counter),
            CounterButton('Add count', pressHandler: _buttonPressedHandler),
          ],
        ),
      ),
    );
  }
}
