import 'package:flutter/material.dart';

class FallbackScreen extends StatelessWidget {
  static const String routeName = '/fallback';

  const FallbackScreen({Key? key}) : super(key: key);

  void _backToRoot(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Not Found'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Center(
            child: Text(
                'Not Found! Something definitely does not work as expected.'),
          ),
          IconButton(
            onPressed: () => _backToRoot(context),
            icon:
                Icon(Icons.home, color: Theme.of(context).colorScheme.primary),
          ),
        ],
      ),
    );
  }
}
