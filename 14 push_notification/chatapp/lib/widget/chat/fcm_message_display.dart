import 'package:chatapp/providers/fcm_messages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FcmMessageDisplay extends StatefulWidget {
  const FcmMessageDisplay({Key? key}) : super(key: key);

  @override
  State<FcmMessageDisplay> createState() => _FcmMessageDisplayState();
}

class _FcmMessageDisplayState extends State<FcmMessageDisplay> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // print('did change depend...');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // print("WidgetsBinding in did change");
      final fcmMessages = Provider.of<FcmMessages>(context, listen: false);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(fcmMessages.latestMessage),
          duration: const Duration(seconds: 3),
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // print('Build FcmMessageDisplay');

    // Visuelle Ausgabe...
    // final fcmMessages = Provider.of<FcmMessages>(context);
    // return Text('tst${fcmMessages.latestMessage}');

    // Augabe nur ueber ScaffoldMessenger im didChangeDependencies
    Provider.of<FcmMessages>(context);
    return Container();
  }
}
