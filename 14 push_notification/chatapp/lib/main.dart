import 'package:chatapp/screens/auth_screen.dart';
import 'package:chatapp/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("(on background) Message id: ${message.messageId}");
  print('(on background) Message data: ${message.data}');

  if (message.notification != null) {
    print('(on background) Message also contained a notification: ${message.notification}');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print('initial token: ${fcmToken ?? 'no token'}');

  FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
    // TODO: If necessary send token to application server.

    // Note: This callback is fired at each app startup and whenever a new token is generated.
    print('new token $fcmToken');
  }).onError((err) {
    // Error getting token.
    print('err on token refresh: ' + err);
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const Application());
}

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from a terminated state.
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleOnStartMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleOnStartMessage);

    // Listen on Messages while in Foreground
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage, onError: (err) {
      print('Firebase messaging stream error' + err);
    });
  }

  void _handleOnStartMessage(RemoteMessage message) {
    print("(on start) Message id: ${message.messageId}");
    print('(on start) Message data: ${message.data}');

    if (message.notification != null) {
      print('(on start) Message also contained a notification: ${message.notification}');
    }
    // It is assumed that all messages contain a data field with the key 'type'
    // if (message.data['type'] == 'chat') {
    //   Navigator.pushNamed(context, '/chat',
    //     arguments: ChatArguments(message),
    //   );
    // }
  }

  void _handleForegroundMessage(RemoteMessage message) {
    print("(on foreground) Message id: ${message.messageId}");
    print('(on foreground) Message data: ${message.data}');

    if (message.notification != null) {
      print('(on foreground) Message also contained a notification: ${message.notification}');
    }
    // It is assumed that all messages contain a data field with the key 'type'
    // if (message.data['type'] == 'chat') {
    //   Navigator.pushNamed(context, '/chat',
    //     arguments: ChatArguments(message),
    //   );
    // }
  }

  @override
  void initState() {
    super.initState();

    // Run code required to handle interacted messages in an async function as initState() must not be async
    setupInteractedMessage();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat',
      theme: ThemeData(
          buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: Colors.pink,
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
              .copyWith(background: Colors.pink, secondary: Colors.deepPurple)),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, userSnapshot) {
          if (userSnapshot.hasData) {
            return const ChatScreen();
          } else {
            return const AuthScreen();
          }
        },
      ),
    );
  }
}
