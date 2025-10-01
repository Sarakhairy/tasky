import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/theme/dark_theme.dart';
import 'package:tasky/core/theme/light_theme.dart';
import 'package:tasky/screens/main_screen.dart';
import 'package:tasky/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await PreferencesManager().init();
  final preferencesManager = PreferencesManager();
  
  String? userName =preferencesManager.getString('username');

  runApp(MyApp(userName: userName));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.userName});
  final String? userName;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tasky',
      theme: darkTheme,
      home: userName == null ? WelcomeScreen() : MainScreen(),
    );
  }
}
