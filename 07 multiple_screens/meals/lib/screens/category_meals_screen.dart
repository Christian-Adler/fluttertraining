import 'package:flutter/material.dart';
import 'package:meals/dummy_data.dart';
import 'package:meals/widgets/meal_item.dart';

import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const String routeName = '/category-meals';

  const CategoryMealsScreen({super.key});

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle = '';
  List<Meal> displayedMeals = [];
  Color categoryColor = Colors.white;
  bool _initOnlyOnce = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_initOnlyOnce) {
      return;
    }
    _initOnlyOnce = true;

    // Geht wg. context nicht schon in initState - daher hier
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, Object>;
    categoryTitle = routeArgs['title'] as String;
    final categoryId = routeArgs['id'] as String;
    categoryColor = routeArgs['color'] as Color;

    displayedMeals = DUMMY_MEALS.where((m) {
      return m.categories.contains(categoryId);
    }).toList();

    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
        backgroundColor: categoryColor,
      ),
      body: ListView.builder(
        itemBuilder: (ctx, idx) {
          return MealItem(displayedMeals[idx], (mealId) {
            _removeMeal(mealId);
          });
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
