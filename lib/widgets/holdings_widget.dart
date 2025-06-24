import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:portfolio_manager/colors.dart';
import 'package:portfolio_manager/providers/api_keys.dart';
import 'package:portfolio_manager/widgets/holding_tile.dart';
import 'package:portfolio_manager/widgets/expandable_list_viewer.dart';
import 'package:provider/provider.dart';

class HoldingsWidget extends StatefulWidget {
  const HoldingsWidget({super.key});

  @override
  State<HoldingsWidget> createState() => _HoldingsWidgetState();
}

class _HoldingsWidgetState extends State<HoldingsWidget> {
  List<Map<String, dynamic>> holdings = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchHoldings();
  }

  Future<void> fetchHoldings() async {
    final creds = Provider.of<AppAuthProvider>(context, listen: false);
    final apiKey = creds.apiKey;
    final secretKey = creds.secretKey;

    // final url =
    // Uri.parse('http://localhost:1305/get-holdings/$apiKey/$secretKey');
    final url =
        Uri.parse('http://192.168.1.5:1305/get-holdings/$apiKey/$secretKey');

    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        final Map<String, dynamic> jsonObject = jsonDecode(res.body);

        // Extract values from the object
        setState(() {
          holdings = jsonObject.values
              .map<Map<String, dynamic>>(
                  (entry) => Map<String, dynamic>.from(entry))
              .toList();
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load holdings");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width - 20,
      decoration: BoxDecoration(
        color: kCardBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Holdings',
            style: TextStyle(
              color: kTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 12),
          isLoading
              ? const CircularProgressIndicator()
              : ExpandableListViewer(
                  tiles: holdings
                      .map((h) => HoldingTile(
                            companyName: h['companyName'] ?? 'Unknown',
                            logoUrl: h['logoUrl'] ?? '',
                            shares: h['shares'] ?? 0,
                            avgPrice: (h['avgPrice'] ?? 0).toDouble(),
                            marketValue: (h['marketValue'] ?? 0).toDouble(),
                            percentageChange:
                                (h['percentageChange'] ?? 0).toDouble(),
                          ))
                      .toList(),
                )
        ],
      ),
    );
  }
}
