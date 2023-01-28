import 'package:flutter/material.dart';

class CounterButton extends StatelessWidget {
  final String title;
  final VoidCallback pressHandler;

  const CounterButton(
    this.title, {
    Key key,
    @required this.pressHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: pressHandler,
      child: Text(title),
      style: ElevatedButton.styleFrom(foregroundColor: Colors.deepPurple),
    );
  }
}
