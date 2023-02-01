import 'package:flutter/material.dart';
import 'package:meals/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const String routeName = '/meal-details';

  const MealDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments as String;
    final meal =
        DUMMY_MEALS.where((element) => element.id == mealId).toList()[0];
    return Scaffold(
      appBar: AppBar(title: Text(meal.title)),
      body: Text('text'),
    );
  }
}
