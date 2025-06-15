import 'package:flutter/material.dart';
import 'package:portfolio_manager/colors.dart';

class HoldingTile extends StatelessWidget {
  final String companyName;
  final String logoUrl;
  final int shares;
  final double avgPrice;
  final double marketValue;
  final double percentageChange;

  const HoldingTile({
    super.key,
    required this.companyName,
    required this.logoUrl,
    required this.shares,
    required this.avgPrice,
    required this.marketValue,
    required this.percentageChange,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPositive = percentageChange >= 0;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: kCardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Logo
          Container(
            width: 44,
            height: 44,
            padding:
                const EdgeInsets.all(6), // ✅ Shrinks image inside the circle
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              color: Colors.white, // or transparent
              image: DecorationImage(
                image: NetworkImage(logoUrl),
                fit: BoxFit.contain, // ✅ shows full logo without crop
                onError: (exception, stackTrace) {},
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Company Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(companyName,
                    style: const TextStyle(
                        color: kTextColor, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(
                  "$shares shares • \$$avgPrice avg",
                  style: const TextStyle(color: kTextMuted, fontSize: 13),
                ),
              ],
            ),
          ),

          // Value and P/L %
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$${marketValue.toStringAsFixed(0)}",
                style: const TextStyle(
                  color: kTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "${isPositive ? '+' : ''}${percentageChange.toStringAsFixed(2)}%",
                style: TextStyle(
                  color: isPositive ? kProfitColor : kLossColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
