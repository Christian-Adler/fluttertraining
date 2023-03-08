import 'package:chatapp/widget/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authId = FirebaseAuth.instance.currentUser?.uid ?? '';

    return StreamBuilder(
      builder: (context, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        var docs = chatSnapshot.data?.docs;
        if (docs == null) return const Text('No chat data!');

        return ListView.builder(
          reverse: true,
          itemBuilder: (ctx, index) => MessageBubble(
            docs[index]['text'],
            docs[index]['userName'] ?? 'unknown',
            docs[index]['userId'] == authId,
            key: ValueKey(docs[index].id),
          ),
          itemCount: docs.length,
        );
      },
      stream: FirebaseFirestore.instance.collection('chat').orderBy('createdAt', descending: true).snapshots(),
    );
  }
}
