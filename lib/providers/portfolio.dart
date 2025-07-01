import 'package:flutter/material.dart';
import 'package:portfolio_manager/models/Portfolio.dart';

class PortfolioProvider with ChangeNotifier {
  Portfolio _portfolio = Portfolio(assets: []);

  Portfolio get portfolio => _portfolio;

  void setPortfolio(Map<String, dynamic> portfolioData) {
    final assets = portfolioData.entries.map((entry) {
      final symbol = entry.key;
      final data = entry.value;
      return Asset(
        name: data['name'] ?? symbol,
        symbol: symbol,
        buyPrice: (data['buyPrice'] ?? 0.0).toDouble(),
        shares: (data['shares'] ?? 0).toInt(),
      );
    }).toList();

    _portfolio = Portfolio(assets: assets);
    notifyListeners();
  }

  void clearPortfolio() {
    _portfolio = Portfolio(assets: []);
    notifyListeners();
  }

  @override
  String toString() {
    return _portfolio.toString();
  }
}
