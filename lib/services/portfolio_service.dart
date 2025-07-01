import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:portfolio_manager/providers/portfolio.dart';

Future<List<Map<String, dynamic>>> fetchPortfolioHistory(
    PortfolioProvider portfolioProvider) async {
  final url = Uri.parse(
      "${dotenv.env['BACKEND_BASE_URL']}/get-past-year-portfolio-value");

  final portfolio = portfolioProvider.portfolio.toMap();
  final jsonPortfolio = jsonEncode({"portfolio": portfolio});
  print(jsonPortfolio);

  final res = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonPortfolio,
  );

  await Future.delayed(
      const Duration(seconds: 1)); // just to check the suspense

  if (res.statusCode == 200) {
    return List<Map<String, dynamic>>.from(jsonDecode(res.body));
  } else {
    throw Exception("Failed to fetch portfolio data");
  }
}

Future<Map<String, dynamic>> fetchPortfolioFromAlpaca({
  required String apiKey,
  required String secretKey,
}) async {
  const alpacaBaseUrl = 'https://paper-api.alpaca.markets/v2/positions';

  final response = await http.get(
    Uri.parse(alpacaBaseUrl),
    headers: {
      'APCA-API-KEY-ID': apiKey,
      'APCA-API-SECRET-KEY': secretKey,
    },
  );

  if (response.statusCode != 200) {
    throw Exception(
        'Failed to fetch portfolio: ${response.statusCode} ${response.body}');
  }

  final List<dynamic> data = jsonDecode(response.body);

  final Map<String, dynamic> portfolioMap = {
    for (var item in data)
      item['symbol']: {
        'name': item['symbol'],
        'shares': int.tryParse(item['qty']) ?? 0,
        'buyPrice': double.tryParse(item['avg_entry_price']) ?? 0.0,
      }
  };

  return portfolioMap;
}

Future<double> getCurrentMarketPrice(String symbol) async {
  final url = Uri.parse(
    "${dotenv.env['BACKEND_BASE_URL']}/get-latest-price/$symbol",
  );

  final response = await http.get(url);

  await Future.delayed(
      const Duration(seconds: 1)); // just to check the suspense

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return (data['latestPrice'] as num?)?.toDouble() ?? 0.0;
  } else {
    throw Exception('Failed to fetch market price: ${response.statusCode}');
  }
}
