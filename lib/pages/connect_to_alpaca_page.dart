import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:portfolio_manager/colors.dart';
import 'package:portfolio_manager/providers/api_keys.dart' show AppAuthProvider;
import 'package:portfolio_manager/providers/portfolio.dart';
import 'package:portfolio_manager/services/authentication.dart';
import 'package:portfolio_manager/services/portfolio_service.dart';
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
    PortfolioProvider portfolioProvider,
    AppAuthProvider alpacaKeyProvider,
    context,
  ) async {
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
      // ✅ Validate credentials with /v2/account
      final accountRes = await http.get(
        Uri.parse('https://paper-api.alpaca.markets/v2/account'),
        headers: {
          'APCA-API-KEY-ID': apiKey,
          'APCA-API-SECRET-KEY': secretKey,
        },
      );

      if (accountRes.statusCode != 200) {
        throw Exception("Invalid API key or secret.");
      }

      // ✅ Fetch and format portfolio using helper
      final portfolioMap = await fetchPortfolioFromAlpaca(
        apiKey: apiKey,
        secretKey: secretKey,
      );

      // ✅ Save credentials to Firestore
      await saveAuthDetails(email!, apiKey, secretKey);

      // ✅ Update providers
      alpacaKeyProvider.setKeys(api: apiKey, secret: secretKey);
      portfolioProvider.setPortfolio(portfolioMap);

      print('✅ Portfolio updated: ${portfolioProvider.portfolio}');

      // ✅ Navigate to dashboard
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
    final portfolioProvider =
        Provider.of<PortfolioProvider>(context, listen: false);
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
                        _handleConnect(portfolioProvider, alpacaKeys, context);
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
