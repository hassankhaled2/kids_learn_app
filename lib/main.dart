import 'package:flutter/material.dart';
import 'package:kids_learn_app/presentation/screens/home_screen.dart';


import 'core/themes/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appThemeData[AppTheme.blueDark],
      home:  HomeScreen(),
    );
  }
}


