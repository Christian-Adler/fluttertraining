import 'package:flutter/material.dart';

class ClickCounterResult extends StatelessWidget {
  final int counter;

  const ClickCounterResult({Key key, @required this.counter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Button pressed x '),
        Text(
          counter.toString(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(' times.')
      ],
    );
  }
}
