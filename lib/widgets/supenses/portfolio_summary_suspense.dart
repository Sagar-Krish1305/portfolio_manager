import 'package:flutter/material.dart';
import 'package:portfolio_manager/colors.dart';
import 'package:shimmer/shimmer.dart';

class PortfolioSummarySuspense extends StatelessWidget {
  const PortfolioSummarySuspense({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width - 20,
      decoration: BoxDecoration(
        color: kCardBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Shimmer.fromColors(
        baseColor: kBackgroundColor.withAlpha(153),
        highlightColor: kPrimaryCyan.withAlpha(76),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Placeholder
            Container(
              height: 28,
              width: 180,
              decoration: BoxDecoration(
                color: kBackgroundColor,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 12),

            // Total Value Placeholder
            Container(
              height: 42,
              width: 160,
              decoration: BoxDecoration(
                color: kBackgroundColor,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 8),

            // Today's Profit Placeholder
            Container(
              height: 20,
              width: 120,
              decoration: BoxDecoration(
                color: kBackgroundColor,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 32),

            // Chart Placeholder
            Center(
              child: Container(
                height: 150,
                width: 300,
                decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Time Filter Row Placeholder
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                3,
                (_) => Container(
                  height: 36,
                  width: 70,
                  decoration: BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
