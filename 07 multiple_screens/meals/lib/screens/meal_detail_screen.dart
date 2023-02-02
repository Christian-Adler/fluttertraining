import 'package:flutter/material.dart';
import 'package:meals/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const String routeName = '/meal-details';

  const MealDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments as String;
    final meal = DUMMY_MEALS.firstWhere((m) => m.id == mealId);
    return Scaffold(
      appBar: AppBar(title: Text(meal.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, idx) {
                  return Card(
                    color: Theme.of(context).colorScheme.secondary,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      child: Text(
                        meal.ingredients[idx],
                      ),
                    ),
                  );
                },
                itemCount: meal.ingredients.length,
              ),
            ),
            buildSectionTitle(context, 'Steps'),
            buildContainer(
              ListView.separated(
                itemBuilder: (ctx, idx) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text('# ${(idx + 1)}'),
                    ),
                    title: Text(
                      meal.steps[idx],
                    ),
                  );
                },
                itemCount: meal.steps.length,
                separatorBuilder: (ctx, idx) => const Divider(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildSectionTitle(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Container buildContainer(Widget widget) {
    return Container(
      height: 200,
      width: 300,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: widget,
    );
  }
}
