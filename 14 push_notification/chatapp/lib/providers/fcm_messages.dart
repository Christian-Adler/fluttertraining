import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FcmMessages with ChangeNotifier {
  String? _latestMessage;

  FcmMessages() {
    // Listen on Messages while in Foreground
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage, onError: (err) {
      print('Firebase messaging stream error' + err);
    });
  }

  void _handleForegroundMessage(RemoteMessage message) {
    print("(on foreground provider) Message id: ${message.messageId}");
    print('(on foreground provider) Message data: ${message.data}');

    if (message.notification != null) {
      print('(on foreground provider) Message also contained a notification: ${message.notification}');
    }

    _latestMessage = message.messageId;
    notifyListeners();
  }

  String get latestMessage {
    return _latestMessage ?? 'no message';
  }
}
