import 'package:flutter/material.dart';
import 'package:portfolio_manager/components/LoginPage.dart';
import 'theme.dart'; // your custom theme

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio Dashboard',
      theme: appDarkTheme,
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
