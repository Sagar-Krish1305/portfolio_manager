import 'package:flutter/material.dart';
import 'package:portfolio_manager/colors.dart'; // Your custom color palette
import 'package:percent_indicator/percent_indicator.dart';

class PortfolioRiskLevelCard extends StatelessWidget {
  const PortfolioRiskLevelCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kCardBackground, // e.g. Color(0xFF1E1E2E)
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Left: Circular gauge
          CircularPercentIndicator(
            radius: 50,
            lineWidth: 10,
            percent: 0.32,
            circularStrokeCap: CircularStrokeCap.round,
            backgroundColor: Colors.grey.withOpacity(0.2),
            progressColor: Colors.orangeAccent,
            center: const Text(
              "Moderate",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(width: 24),

          // Right: Risk metrics
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your Portfolio Risk Level",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: kTextColor,
                  ),
                ),
                SizedBox(height: 12),
                RiskMetricRow(label: "Volatility Score", value: "3.2/10"),
                RiskMetricRow(label: "Beta vs. Market", value: "1.1"),
                RiskMetricRow(label: "Value at Risk", value: "₹15,000"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Helper widget for metric rows
class RiskMetricRow extends StatelessWidget {
  final String label;
  final String value;

  const RiskMetricRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(label,
                style: const TextStyle(
                  fontSize: 14,
                  color: kTextMuted,
                )),
          ),
          Text(value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: kTextColor,
              )),
        ],
      ),
    );
  }
}
