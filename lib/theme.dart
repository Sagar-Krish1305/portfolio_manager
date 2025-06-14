import 'package:flutter/material.dart';
import 'colors.dart';

final ThemeData appDarkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: kBackgroundColor,
  primaryColor: kPrimaryTeal,
  fontFamily: 'Roboto',

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.black12,
    labelStyle: const TextStyle(color: Colors.white70),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kPrimaryTeal,
      foregroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 14),
      textStyle: const TextStyle(fontSize: 16),
    ),
  ),

  textTheme: const TextTheme(
    titleLarge: TextStyle(color: Colors.white, fontSize: 24),
    titleMedium: TextStyle(color: Colors.white70),
    bodyMedium: TextStyle(color: Colors.white),
  ),
);
