import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  // final Function selectHandler;
  final VoidCallback selectHandler; // more specific than Function
  final String answerText;

  Answer(this.selectHandler, this.answerText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        child: Text(answerText),
        onPressed: selectHandler,
        // style: ButtonStyle(
        //     backgroundColor: MaterialStateProperty.all(Colors.cyan),
        //     foregroundColor: MaterialStateProperty.all(Colors.white),
        // ),
      ),
    );
  }
}
