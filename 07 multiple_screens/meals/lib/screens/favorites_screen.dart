import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

  const FavoritesScreen(this.favoriteMeals, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return const Center(child: Text('No favorites yet - start adding some'));
    }

    return ListView.builder(
      itemBuilder: (ctx, idx) {
        return MealItem(
          favoriteMeals[idx],
        );
      },
      itemCount: favoriteMeals.length,
    );
  }
}
