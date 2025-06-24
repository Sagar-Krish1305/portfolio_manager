import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Map<String, dynamic>>> fetchPortfolioHistory() async {
  final url =
      Uri.parse("http://172.20.10.2:1305/get-past-year-portfolio-value");

  final defaultPortfolio = {
    "portfolio": {
      "MSFT": {"shares": 12, "buyPrice": 140},
      "GOOGL": {"shares": 12, "buyPrice": 140},
    }
  };

  final res = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(defaultPortfolio),
  );

  await Future.delayed(const Duration(seconds: 1));

  if (res.statusCode == 200) {
    return List<Map<String, dynamic>>.from(jsonDecode(res.body));
  } else {
    throw Exception("Failed to fetch portfolio data");
  }
}
