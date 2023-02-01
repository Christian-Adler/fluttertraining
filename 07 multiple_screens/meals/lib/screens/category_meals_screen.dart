import 'package:flutter/material.dart';
import 'package:meals/dummy_data.dart';
import 'package:meals/widgets/meal_item.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const String routeName = '/category-meals';

  const CategoryMealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final categoryTitle = routeArgs['title'] as String;
    final categoryId = routeArgs['id'];

    final categoryMeals = DUMMY_MEALS.where((m) {
      return m.categories.contains(categoryId);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, idx) {
          return MealItem(categoryMeals[idx]);
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}
