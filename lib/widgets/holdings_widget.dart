import 'package:flutter/material.dart';
import 'package:portfolio_manager/colors.dart';
import 'package:portfolio_manager/providers/portfolio.dart';
import 'package:portfolio_manager/services/portfolio_service.dart';
import 'package:portfolio_manager/widgets/holding_tile.dart';
import 'package:portfolio_manager/widgets/expandable_list_viewer.dart';
import 'package:portfolio_manager/widgets/supenses/holdings_suspense.dart';
import 'package:provider/provider.dart';

class HoldingsWidget extends StatelessWidget {
  const HoldingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final portfolio = Provider.of<PortfolioProvider>(context).portfolio.toMap();

    final holdingsFutures = portfolio.entries.map((entry) async {
      final symbol = entry.key;
      final data = entry.value;
      final shares = data['shares'] ?? 0;
      final buyPrice = (data['buyPrice'] ?? 0).toDouble();

      print(
          'Processing holding: $symbol, Shares: $shares, Buy Price: $buyPrice');

      final marketPrice = await getCurrentMarketPrice(symbol);
      final marketValue = shares * marketPrice;
      final change = ((marketPrice - buyPrice) / buyPrice) * 100;

      return {
        'symbol': symbol,
        'shares': shares,
        'avgPrice': buyPrice,
        'marketValue': marketValue,
        'percentageChange': change,
      };
    }).toList();

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: Future.wait(holdingsFutures),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: HoldingsSuspense());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final holdings = snapshot.data ?? [];
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
              ExpandableListViewer(
                tiles: holdings
                    .map((h) => HoldingTile(
                          companyName: h['symbol'] ?? 'Unknown',
                          logoUrl: '', // No logo
                          shares: h['shares'],
                          avgPrice: h['avgPrice'],
                          marketValue: h['marketValue'],
                          percentageChange: h['percentageChange'],
                        ))
                    .toList(),
              )
            ],
          ),
        );
      },
    );
  }
}
