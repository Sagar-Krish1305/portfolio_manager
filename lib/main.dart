import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:portfolio_manager/pages/connect_to_alpaca.dart';
import 'package:portfolio_manager/pages/dashboard_page.dart';
import 'package:portfolio_manager/pages/login_page.dart';
import 'package:portfolio_manager/pages/signup_page.dart';
import 'theme.dart'; // your custom theme

Future<void> main() async {
  await dotenv.load();
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
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/api_key_configuration': (context) => const ConnectToAlpacaPage(),
      },
    );
  }
}
