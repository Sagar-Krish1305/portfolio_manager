import 'package:flutter/material.dart';
import 'package:portfolio_manager/colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(color: Colors.white, fontSize: 16);
    const labelStyle = TextStyle(color: Colors.grey);

    InputDecoration inputStyle(String label) => InputDecoration(
          labelText: label,
          labelStyle: labelStyle,
          filled: true,
          fillColor: const Color(0xFF1A1A1A),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        );

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                const SizedBox(height: 40),
                const CircleAvatar(
                  radius: 48,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, size: 60, color: Colors.black),
                ),
                const SizedBox(height: 16),
                const Text("Profile",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 32),
                TextField(
                  style: textStyle,
                  decoration: inputStyle("Username"),
                  controller: TextEditingController(text: "john_doe"),
                ),
                const SizedBox(height: 16),
                TextField(
                  style: textStyle,
                  decoration: inputStyle("Email"),
                  controller:
                      TextEditingController(text: "john.doe@example.com"),
                ),
                const SizedBox(height: 16),
                TextField(
                  style: textStyle,
                  decoration: inputStyle("Alpaca API Key"),
                  controller: TextEditingController(text: "AK1234567890"),
                ),
                const SizedBox(height: 16),
                TextField(
                  style: textStyle,
                  decoration: inputStyle("Alpaca Secret Key"),
                  controller:
                      TextEditingController(text: "SK0987654321"),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    // Handle change password
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2C2C2C),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    minimumSize: const Size.fromHeight(48),
                  ),
                  child: const Text("Change Password",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Handle logout
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2C2C2C),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    minimumSize: const Size.fromHeight(48),
                  ),
                  child: const Text("Log Out",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
