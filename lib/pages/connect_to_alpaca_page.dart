import 'package:flutter/material.dart';
import 'package:portfolio_manager/colors.dart';
import 'package:portfolio_manager/providers/api_keys.dart' show AppAuthProvider;
import 'package:portfolio_manager/services/authentication.dart';
import 'package:provider/provider.dart';

class ConnectToAlpacaPage extends StatefulWidget {
  const ConnectToAlpacaPage({super.key});

  @override
  State<ConnectToAlpacaPage> createState() => _ConnectToAlpacaPageState();
}

class _ConnectToAlpacaPageState extends State<ConnectToAlpacaPage> {
  final TextEditingController apiKeyController = TextEditingController();
  final TextEditingController secretKeyController = TextEditingController();

  Future<void> _handleConnect(
      AppAuthProvider alpacaKeyProvider, context) async {
    final email = alpacaKeyProvider.email;
    final apiKey = apiKeyController.text.trim();
    final secretKey = secretKeyController.text.trim();

    if (apiKey.isEmpty || secretKey.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Both fields are required")),
      );
      return;
    }

    try {
      // Save to Firestore
      await saveAuthDetails(email!, apiKey, secretKey);

      // Update local provider
      alpacaKeyProvider.setKeys(api: apiKey, secret: secretKey);

      // Route to dashboard
      Navigator.pushReplacementNamed(context, '/dashboard');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to connect: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final alpacaKeys = Provider.of<AppAuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Container(
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              width: 400,
              decoration: BoxDecoration(
                color: kCardBackground,
                borderRadius: BorderRadius.circular(20),
              ),
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
                    'Connect to Alpaca',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: apiKeyController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(labelText: 'API Key'),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: secretKeyController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(labelText: 'Secret Key'),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _handleConnect(alpacaKeys, context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryCyan,
                        foregroundColor: Colors.black,
                      ),
                      child: const Text(
                        'Continue',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
