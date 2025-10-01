import 'package:flutter/material.dart';

ThemeData lighTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primaryContainer: Color(0xFFD1DAD6)
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(Color(0xFF15B86C)),
      foregroundColor: WidgetStateProperty.all(Colors.white),
    ),
  ),
  scaffoldBackgroundColor: Color(0xfff6f9f9),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFFF6F7F9),
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
  ),
  textTheme: TextTheme(
    displaySmall: TextStyle(
      fontSize: 24,
      color: Color(0xFF161F1B),
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      color: Color(0xFF161F1B),
      fontWeight: FontWeight.w400,
    ),
     displayLarge: TextStyle(
      fontSize: 32,
      color: Color(0xFF161F1B),
      fontWeight: FontWeight.w400,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      color: Color(0xFF161f1b),
      fontWeight: FontWeight.w400,
    ),
     titleMedium: TextStyle(
      fontSize: 16,
      color: Color(0xFF161f1b),
      fontWeight: FontWeight.w400,
    ),
    titleLarge: TextStyle(
        color: Color(0xff6a6a6a),
        fontSize: 16,
        decoration: TextDecoration.lineThrough,
        overflow: TextOverflow.ellipsis,
        decorationColor: Color(0xff49454F),
        
      ),
    labelMedium: TextStyle(color: Colors.black, fontSize: 16),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: Color(0xFF9E9E9E)),
    filled: true,
    fillColor: Colors.white,
    focusColor: Color(0xFFD1DAD6),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xFFD1DAD6)),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.red),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xFFD1DAD6)),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xFFD1DAD6)),
    ),
  ),
);
