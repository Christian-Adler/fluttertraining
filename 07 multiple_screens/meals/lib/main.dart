import 'package:flutter/material.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/category_meals_screen.dart';
import 'package:meals/screens/fallback_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
            .copyWith(
                secondary: Colors.amber,
                background: const Color.fromRGBO(255, 254, 229, 1)),
        textTheme: ThemeData.light().textTheme.copyWith(
              labelLarge: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
                fontFamily: 'RobotoCondensed',
              ),
              labelMedium: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
                fontFamily: 'RobotoCondensed',
              ),
              titleLarge: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Raleway',
              ),
            ),
      ),
      home: const CategoriesScreen(),
      routes: {
        //  '/' : (ctx) => entspricht home-Screen
        CategoryMealsScreen.routeName: (ctx) => const CategoryMealsScreen(),
        // MealDetailScreen.routeName: (ctx) => const MealDetailScreen(),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        // generic route dispatch
        // if(settings.name==...)
        //   return ...
        // return MaterialPageRoute(builder: (ctx) => const CategoriesScreen());
      },
      onUnknownRoute: (settings) {
        // Prevent app crash and show at least something on the screen. e.g. not found.
        return MaterialPageRoute(builder: (ctx) {
          return const FallbackScreen(); // This should never really be seen.
        });
      },
    );
  }
}
