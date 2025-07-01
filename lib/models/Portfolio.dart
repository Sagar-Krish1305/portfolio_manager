import 'dart:convert';

import 'package:http/http.dart' as http;

class Asset {
  final String name;
  final String symbol;
  final double buyPrice;
  final int shares;

  Asset({
    required this.name,
    required this.symbol,
    required this.buyPrice,
    required this.shares,
  });

  double get value => buyPrice * shares;

  @override
  String toString() {
    return '$symbol: $shares shares @ \$$buyPrice = \$$value';
  }
}

class Portfolio {
  final List<Asset> assets;

  Portfolio({required this.assets});

  double get totalValue => assets.fold(0, (sum, asset) => sum + asset.value);

  int get totalShares => assets.fold(0, (sum, asset) => sum + asset.shares);

  @override
  String toString() {
    final buffer = StringBuffer();

    // Header
    buffer.writeln(
        '---------------------------------------------------------------');
    buffer.writeln(
        '| ${'Symbol'.padRight(8)} | ${'Name'.padRight(20)} | ${'Shares'.padLeft(6)} | ${'Buy Price'.padLeft(10)} | ${'Value'.padLeft(10)} |');
    buffer.writeln(
        '---------------------------------------------------------------');

    // Rows
    for (final asset in assets) {
      buffer.writeln(
          '| ${asset.symbol.padRight(8)} | ${asset.name.padRight(20).substring(0, 20)} | ${asset.shares.toString().padLeft(6)} | \$${asset.buyPrice.toStringAsFixed(2).padLeft(9)} | \$${asset.value.toStringAsFixed(2).padLeft(9)} |');
    }

    buffer.writeln(
        '---------------------------------------------------------------');
    buffer.writeln('Total Portfolio Value: \$${totalValue.toStringAsFixed(2)}');
    return buffer.toString();
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> portfolioMap = {};
    // { 'symbol': {'name': 'Asset Name', 'buyPrice': 100.0, 'shares': 10} }
    for (final asset in assets) {
      portfolioMap[asset.symbol] = {
        'name': asset.name,
        'buyPrice': asset.buyPrice,
        'shares': asset.shares,
      };
    }
    return portfolioMap;
  }
}
