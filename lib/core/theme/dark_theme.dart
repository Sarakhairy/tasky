import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primaryContainer: Color(0xFF2b2b2b)
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(Color(0xFF15B86C)),
      foregroundColor: WidgetStateProperty.all(Colors.white),
    ),
  ),
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF181818),
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
  ),
  textTheme: TextTheme(
    displaySmall: TextStyle(
      fontSize: 24,
      color: Color(0xFFFFFCFC),
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      color: Color(0xFFFFFFFF),
      fontWeight: FontWeight.w400,
    ),
    displayLarge: TextStyle(
      fontSize: 32,
      color: Color(0xFFFFFFFF),
      fontWeight: FontWeight.w400,
    ),
      titleSmall: TextStyle(
      fontSize: 14,
      color: Color(0xFfFFFCFC),
      fontWeight: FontWeight.w400,
      ),
      titleMedium: TextStyle(
      fontSize: 16,
      color: Color(0xFfFFFCFC),
      fontWeight: FontWeight.w400,
      ),
      titleLarge: TextStyle(
        color: Color(0xffaDadad),
        fontSize: 16,
        decoration: TextDecoration.lineThrough,
        overflow: TextOverflow.ellipsis,
        decorationColor: Color(0xffaDadad),
        fontWeight: FontWeight.w400,
      ),
    labelMedium: TextStyle(color: Colors.white, fontSize: 16),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: Color(0xFf6D6D6D)),
    filled: true,
    fillColor: Color(0xFF282828),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.red),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
  ),
);
