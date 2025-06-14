import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AlpacaServices {
  Future<List<Map<String, dynamic>>> getAlpacaHoldings() async {
    const String baseUrl = "https://paper-api.alpaca.markets/v2";
    final url = Uri.parse('$baseUrl/positions');
    final response = await http.get(
      url,
      headers: {
        'APCA-API-KEY-ID': dotenv.env['ALPACA_API_KEY']!,
        'APCA-API-SECRET-KEY': dotenv.env['ALPACA_SECRET_KEY']!,
      },
    );
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch holdings: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> getMarketSnapshot(String ticker) async {
    final url =
        Uri.parse('https://data.alpaca.markets/v2/stocks/$ticker/snapshot');
    final response = await http.get(
      url,
      headers: {
        'APCA-API-KEY-ID': dotenv.env['ALPACA_API_KEY']!,
        'APCA-API-SECRET-KEY': dotenv.env['ALPACA_SECRET_KEY']!,
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch market data: ${response.statusCode}');
    }
  }
}
