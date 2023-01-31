import 'package:flutter/material.dart';

class CategoryMealsScreen extends StatelessWidget {
  const CategoryMealsScreen({super.key});

  // final String categoryId;
  // final String categoryTitle;
  //
  // const CategoryMealsScreen(this.categoryId, this.categoryTitle, {Key? key})
  //     : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final categoryTitle = routeArgs['title'] as String;
    final categoryId = routeArgs['id'];

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: const Center(
        child: Text('Screen 2'),
      ),
    );
  }
}
