import 'package:flutter/material.dart';
import 'package:portfolio_manager/colors.dart';
import 'package:portfolio_manager/widgets/expandable_list_viewer.dart';
import 'package:portfolio_manager/widgets/holding_tile.dart';

class HoldingsWidget extends StatefulWidget {
  const HoldingsWidget({super.key});

  @override
  State<HoldingsWidget> createState() => _HoldingsWidgetState();
}

class _HoldingsWidgetState extends State<HoldingsWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width - 20,
      decoration: BoxDecoration(
        color: kCardBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Holdings',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          // HoldingTile(
          //   companyName: 'Microsoft',
          //   logoUrl: 'https://logo.clearbit.com/microsoft.com',
          //   shares: 8,
          //   avgPrice: 250.00,
          //   marketValue: 2000,
          //   percentageChange: 0.0, // no change
          // ),
          // HoldingTile(
          //   companyName: 'Microsoft',
          //   logoUrl: 'https://logo.clearbit.com/microsoft.com',
          //   shares: 8,
          //   avgPrice: 250.00,
          //   marketValue: 2000,
          //   percentageChange: 0.0, // no change
          // ),
          // HoldingTile(
          //   companyName: 'Tesla',
          //   logoUrl: 'https://logo.clearbit.com/tesla.com',
          //   shares: 5,
          //   avgPrice: 700.00,
          //   marketValue: 3200,
          //   percentageChange: -4.2, // -4.2%
          // ),
          // HoldingTile(
          //   companyName: 'Apple',
          //   logoUrl: 'https://logo.clearbit.com/apple.com',
          //   shares: 10,
          //   avgPrice: 150.00,
          //   marketValue: 125000,
          //   percentageChange: 3.5, // +3.5%
          // )
          ExpandableListViewer(tiles: [
            HoldingTile(
              companyName: 'Microsoft',
              logoUrl: 'https://logo.clearbit.com/microsoft.com',
              shares: 8,
              avgPrice: 250.00,
              marketValue: 2000,
              percentageChange: 0.0, // no change
            ),
            HoldingTile(
              companyName: 'Microsoft',
              logoUrl: 'https://logo.clearbit.com/microsoft.com',
              shares: 8,
              avgPrice: 250.00,
              marketValue: 2000,
              percentageChange: 0.0, // no change
            ),
            HoldingTile(
              companyName: 'Tesla',
              logoUrl: 'https://logo.clearbit.com/tesla.com',
              shares: 5,
              avgPrice: 700.00,
              marketValue: 3200,
              percentageChange: -4.2, // -4.2%
            ),
            HoldingTile(
              companyName: 'Apple',
              logoUrl: 'https://logo.clearbit.com/apple.com',
              shares: 10,
              avgPrice: 150.00,
              marketValue: 125000,
              percentageChange: 3.5, // +3.5%
            )
          ])
        ],
      ),
    );
  }
}
