import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xff094d6b);
  static const Color secondaryColor = Colors.grey;
  static const Color accentColor = Colors.deepPurple;

  // Change this to whatever color you want for all text
  static const Color globalTextColor = Color(0xff094d6b);

  ThemeData get themeData {
    final base = ThemeData.from(
      colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
    );
    return base.copyWith(
      // Apply the global text color to all text styles
      textTheme: base.textTheme.apply(
        bodyColor: globalTextColor,
        displayColor: globalTextColor,
      ),
      primaryTextTheme: base.primaryTextTheme.apply(
        bodyColor: globalTextColor,
        displayColor: globalTextColor,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
          ),
        ),
      ),
    );
  }
}
