import 'package:flutter/material.dart';
import 'package:portfolio_manager/pages/dashboard_page.dart';
import 'package:portfolio_manager/pages/login_page.dart';
import 'theme.dart'; // your custom theme

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trackfolio',
      theme: appDarkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/dashboard': (context) => const DashboardPage()
      },
    );
  }
}
