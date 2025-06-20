import 'package:flutter/material.dart';

class AlpacaKeys with ChangeNotifier {
  String? apiKey;
  String? secretKey;

  void setKeys(String api, String secret) {
    apiKey = api;
    secretKey = secret;
    notifyListeners();
  }

  bool get isConfigured => apiKey != null && secretKey != null;
}
