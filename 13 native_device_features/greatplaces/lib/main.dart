import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/great_places.dart';
import 'screens/places_list_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo).copyWith(secondary: Colors.amber),
        ),
        home: const PlacesListScreen(),
      ),
    );
  }
}
