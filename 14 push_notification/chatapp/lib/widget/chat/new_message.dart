import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredMessage = '';
  final _controller = TextEditingController();

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    var userId = FirebaseAuth.instance.currentUser?.uid;
    var userData = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    var userName = userData.data()?['username'] ?? 'Unknown user';
    FirebaseFirestore.instance
        .collection('chat')
        .add({'text': _enteredMessage, 'createdAt': Timestamp.now(), 'userId': userId, 'userName': userName});
    _controller.clear();
    setState(() {
      _enteredMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(labelText: 'Send a message...'),
            onChanged: (value) {
              setState(() {
                _enteredMessage = value.trim();
              });
            },
          ),
        ),
        IconButton(
          onPressed: _enteredMessage.isEmpty ? null : _sendMessage,
          icon: Icon(Icons.send, color: _enteredMessage.isEmpty ? null : Theme.of(context).colorScheme.primary),
        ),
      ]),
    );
  }
}
