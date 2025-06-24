import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppAuthProvider with ChangeNotifier {
  String? apiKey;
  String? secretKey;
  String? email;

  void setEmail(String newEmail) {
    email = newEmail;
    notifyListeners();
  }

  void setKeys({
    required String api,
    required String secret,
  }) {
    apiKey = api;
    secretKey = secret;
    notifyListeners();
  }

  bool get isConfigured => apiKey != null && secretKey != null && email != null;

  void clear() {
    apiKey = null;
    secretKey = null;
    email = null;
    notifyListeners();
  }

  Future<void> loadApiKeys(String emailAddress) async {
    try {
      final query = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: emailAddress)
          .limit(1)
          .get();

      if (query.docs.isNotEmpty) {
        final data = query.docs.first.data();
        apiKey = data['apiKey'];
        secretKey = data['secretKey'];
        email = data['email'];
        notifyListeners();
      } else {
        debugPrint('⚠️ No API keys found for $emailAddress');
      }
    } catch (e) {
      debugPrint('❌ Error fetching API keys: $e');
    }
  }
}
