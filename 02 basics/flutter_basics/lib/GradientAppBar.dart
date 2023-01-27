import 'package:flutter/material.dart';

class GradientAppBar extends AppBar {
  GradientAppBar({@required Widget title, @required List<Color> gradientColors})
      : super(
          title: title,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: gradientColors),
            ),
          ),
        );
}
