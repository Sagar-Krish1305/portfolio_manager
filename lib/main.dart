import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:portfolio_manager/pages/connect_to_alpaca_page.dart';
import 'package:portfolio_manager/pages/dashboard_page.dart';
import 'package:portfolio_manager/pages/login_page.dart';
import 'package:portfolio_manager/pages/risk_analysis_page.dart';
import 'package:portfolio_manager/pages/signup_page.dart';
import 'package:portfolio_manager/providers/api_keys.dart';
import 'package:provider/provider.dart';
import 'theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppAuthProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trackfolio',
      theme: appDarkTheme,
      debugShowCheckedModeBanner: false,
      // We’ll use onGenerateInitialRoutes to handle auth state
      initialRoute: '/',
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/api_key_configuration': (context) => const ConnectToAlpacaPage(),
        '/risk_analysis': (context) => const RiskAnalysisPage(),
      },
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // While checking auth state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }

        // If user is logged in
        // if (snapshot.hasData) {
        //   // comment this to reach the login page
        //   // You can access user data here
        //   print(snapshot.data!.email);
        //   return const DashboardPage();
        // }

        // If user is NOT logged in
        return const LoginPage();
      },
    );
  }
}
