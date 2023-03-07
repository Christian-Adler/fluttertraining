import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          DropdownButton(
            items: [
              DropdownMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(
                      Icons.exit_to_app,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      'Logout',
                      style: TextStyle(color: Colors.blue),
                    )
                  ],
                ),
              ),
            ],
            onChanged: (value) {
              if (value == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
            underline: Container(),
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('chats/mQhIKIQ9uNtTHCPN3g0K/messages').snapshots(),
        builder: (context, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            const Center(child: CircularProgressIndicator());
          }

          var documents = streamSnapshot.data?.docs;
          if (documents == null) return const Center(child: Text('No documents...'));

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.all(8),
              child: Text(documents[index].data()['text']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/mQhIKIQ9uNtTHCPN3g0K/messages')
              .add({'text': 'This was added by clicking the button'});
        },
      ),
    );
  }
}
