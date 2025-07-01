import 'package:flutter/material.dart';
import 'package:portfolio_manager/colors.dart';
import 'package:portfolio_manager/providers/api_keys.dart';
import 'package:portfolio_manager/providers/portfolio.dart';
import 'package:portfolio_manager/services/authentication.dart';
import 'package:portfolio_manager/services/portfolio_service.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> _handleLogin(
    AppAuthProvider appAuthProvider,
    PortfolioProvider portfolioProvider,
    context,
  ) async {
    setState(() => isLoading = true);
    final authService = AuthService();

    try {
      final User? userCredential = await authService.signIn(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      final email = userCredential?.email;
      if (email == null) throw Exception("User email not found.");

      // 1️⃣ Load API keys from Firestore
      await appAuthProvider.loadApiKeys(email);
      final apiKey = appAuthProvider.apiKey;
      final secretKey = appAuthProvider.secretKey;

      if (apiKey == null || secretKey == null) {
        throw Exception("API Key or Secret Key missing.");
      }

      // 2️⃣ Fetch portfolio from Alpaca
      final portfolioMap = await fetchPortfolioFromAlpaca(
        apiKey: apiKey,
        secretKey: secretKey,
      );

      // 3️⃣ Update provider
      portfolioProvider.setPortfolio(portfolioMap);

      // 4️⃣ Navigate to dashboard
      Navigator.pushReplacementNamed(context, '/dashboard');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: ${e.toString()}')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appAuthProvider =
        Provider.of<AppAuthProvider>(context, listen: false);
    final portfolioProvider =
        Provider.of<PortfolioProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: kCardBackground,
            borderRadius: BorderRadius.circular(20),
          ),
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Portfolio Dashboard',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Login',
                style: TextStyle(
                  color: kPrimaryCyan,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: emailController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(labelText: 'Email address'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 24),
              isLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _handleLogin(
                            appAuthProvider, portfolioProvider, context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryCyan,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          minimumSize: const Size.fromHeight(48),
                        ),
                        child: const Text('Login'),
                      ),
                    ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don’t have an account? ",
                      style: TextStyle(color: kTextMuted)),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/signup');
                    },
                    child: const Text('Sign up',
                        style: TextStyle(color: kPrimaryCyan)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
