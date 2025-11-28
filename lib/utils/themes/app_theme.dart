import 'package:flutter/material.dart';
import 'package:kids_learn_app/utils/app_strings.dart';

import 'app_colors.dart';

enum AppTheme {
  blueDark("Blue Dark"),
  redDark("Red Dark");

  const AppTheme(this.name);
  final String name;
}

// This is map represent key & value
final appThemeData = {
  AppTheme.blueDark: ThemeData(
    textTheme: TextTheme(
      // The default style for most general text (Text widgets)
      bodyMedium: TextStyle(color: Colors.white),
      // A slightly larger body text style
      bodyLarge: TextStyle(color: Colors.black),
      // Headings and titles often use different styles too
      titleLarge: TextStyle(color: Colors.black),
      // If you are using Material 3, also check the new styles:
      // displayLarge, headlineMedium, etc.
    ),
    scaffoldBackgroundColor:  AppColors.mainColor,
    appBarTheme: AppBarTheme(backgroundColor: AppColors.darkShadeBlueColor),
    dialogTheme: DialogTheme(backgroundColor: AppColors.mainColor),
    colorScheme: ColorScheme.fromSeed(
        //external color of the buttons
        seedColor: AppColors.pinkColor,
        primary: AppColors.pinkColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.pinkColor,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
      foregroundColor: MaterialStatePropertyAll(
          Color(0xFF2F4EFF)), // This will set the text color to black
    )),
    // brightness: Brightness.dark,
  ),
  AppTheme.redDark: ThemeData(
    textTheme: TextTheme(
        // // bodyLarge: TextStyle(color: Colors.white), // For general text
        // bodyMedium: TextStyle(color: Colors.black26),  // For secondary text
        // // displayLarge: TextStyle(color: Colors.blue),  // For large headlines
        ),
    // appBarTheme: AppBarTheme(backgroundColor: Colors.red[700]),
    brightness: Brightness.dark,
    // primaryColor: Colors.red[700],
  ),
};
