import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_manager/colors.dart';
import 'package:portfolio_manager/providers/api_keys.dart';
import 'package:provider/provider.dart'; // your custom color file

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController apiKeyController = TextEditingController();
  final TextEditingController secretKeyController = TextEditingController();

  void handleSubmit() async {
    final password = passwordController.text.trim();
    final apiKey = apiKeyController.text.trim();
    final secretKey = secretKeyController.text.trim();

    final updates = <String, dynamic>{};
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in')),
      );
      return;
    }

    final appAuthProvider =
        Provider.of<AppAuthProvider>(context, listen: false);

    if (password.isNotEmpty) {
      try {
        await user.updatePassword(password);
        updates['passwordChanged'] = true; // optional marker
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password update failed: ${e.toString()}')),
        );
        return;
      }
    }

    if (apiKey.isNotEmpty) {
      updates['apiKey'] = apiKey;
    }

    if (secretKey.isNotEmpty) {
      updates['secretKey'] = secretKey;
    }

    if (updates.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nothing to update')),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update(updates);

      // Reflect updates in Provider
      appAuthProvider.setKeys(
        api: apiKey.isNotEmpty ? apiKey : appAuthProvider.apiKey ?? '',
        secret:
            secretKey.isNotEmpty ? secretKey : appAuthProvider.secretKey ?? '',
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving to Firestore: ${e.toString()}')),
      );
    }
  }

  void handleLogout(context) async {
    try {
      // Firebase sign out
      await FirebaseAuth.instance.signOut();

      // Clear provider data
      Provider.of<AppAuthProvider>(context, listen: false).clear();

      // Navigate to login screen and remove back stack
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/login', // replace with your login route
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout failed: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: const Text("Profile Settings"),
        backgroundColor: kCardBackground,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            _label("Change Password"),
            _textField(passwordController, "Enter new password",
                isObscure: true),
            const SizedBox(height: 24),
            _label("Alpaca API Key"),
            _textField(apiKeyController, "Enter Alpaca API Key"),
            const SizedBox(height: 16),
            _label("Alpaca Secret Key"),
            _textField(secretKeyController, "Enter Alpaca Secret Key"),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: handleSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryCyan,
                foregroundColor: Colors.black,
              ),
              child: const Text('Submit Changes'),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () => handleLogout(context),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.redAccent,
                side: const BorderSide(color: Colors.redAccent),
              ),
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) => Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );

  Widget _textField(TextEditingController controller, String hint,
      {bool isObscure = false}) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: kCardBackground,
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[500]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
