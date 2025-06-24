import 'dart:async';
import 'dart:io';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_manager/colors.dart';
import 'package:portfolio_manager/widgets/gradient_text.dart';
import 'package:portfolio_manager/widgets/supenses/portfolio_summary_suspense.dart';
import 'package:portfolio_manager/widgets/time_filter_row.dart';
import 'package:portfolio_manager/services/portfolio_service.dart';
import 'dart:math';

class PortfolioSummaryWidget extends StatefulWidget {
  const PortfolioSummaryWidget({super.key});

  @override
  State<PortfolioSummaryWidget> createState() => _PortfolioSummaryWidgetState();
}

class _PortfolioSummaryWidgetState extends State<PortfolioSummaryWidget> {
  List<FlSpot> chartData = [];
  List<FlSpot> fullChartData = [];
  String selectedRange = "1Y";
  double totalValue = 0;
  double todayProfit = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final data = await fetchPortfolioHistory(); // fetch from backend

      final sorted = data
          .map((e) => {
                'date': DateTime.parse(e['date']),
                'value': (e['value'] as num).toDouble(),
                'profit': (e['unrealizedProfit'] as num).toDouble(),
              })
          .toList()
        ..sort(
            (a, b) => (a['date'] as DateTime).compareTo(b['date'] as DateTime));

      final spots = sorted.asMap().entries.map((entry) {
        return FlSpot(entry.key.toDouble(), entry.value['value'] as double);
      }).toList();

      setState(() {
        fullChartData = spots;
        chartData = _filterByRange(spots, sorted.length);
        totalValue = sorted.last['value'] as double;
        if (sorted.length >= 2) {
          todayProfit = (sorted.last['profit'] as double) -
              (sorted[sorted.length - 2]['profit'] as double);
        } else {
          todayProfit = 0;
        }
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching portfolio data: $e");
      setState(() => isLoading = false);
    }
  }

  List<FlSpot> _filterByRange(List<FlSpot> all, int totalLength) {
    int totalLength = all.length;

    int count = switch (selectedRange) {
      "1W" => 7,
      "1M" => 30,
      "3M" => 90,
      "1Y" => 365,
      _ => totalLength,
    };

    // Get the last `count` elements (if available)
    return all.sublist(max(0, totalLength - count), totalLength);
  }

  void _onFilterChange(String range) {
    setState(() {
      selectedRange = range;
      chartData = _filterByRange(fullChartData, fullChartData.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: PortfolioSummarySuspense())
        : Container(
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
                  'Total Portfolio Value',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                GradientText(
                  text: "\$${totalValue.toStringAsFixed(0)}",
                  style: const TextStyle(
                      fontSize: 42, fontWeight: FontWeight.bold),
                  gradient: const LinearGradient(
                      colors: [kProfitColor, kPrimaryCyan]),
                ),
                GradientText(
                  text:
                      "${todayProfit >= 0 ? '+' : ''}\$${todayProfit.toStringAsFixed(0)} Today",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600),
                  gradient: const LinearGradient(
                      colors: [kProfitColor, kProfitColor]),
                ),
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 150,
                        width: 300,
                        child: LineChart(LineChartData(
                          lineBarsData: [
                            LineChartBarData(
                              spots: chartData,
                              isCurved: true,
                              color: Colors.transparent,
                              gradient: const LinearGradient(
                                colors: [kProfitColor, kPrimaryCyan],
                              ),
                              belowBarData: BarAreaData(
                                show: true,
                                gradient: LinearGradient(
                                  colors: [
                                    kProfitColor.withAlpha(50),
                                    kPrimaryCyan.withAlpha(10),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              shadow: const Shadow(
                                blurRadius: 6,
                                color: Colors.black45,
                                offset: Offset(2, 4),
                              ),
                              barWidth: 2,
                              dotData: const FlDotData(show: false),
                            ),
                          ],
                          gridData: const FlGridData(show: false),
                          titlesData: const FlTitlesData(show: false),
                          borderData: FlBorderData(show: false),
                        )),
                      ),
                      const SizedBox(height: 16),
                      TimeFilterRow(onSelected: _onFilterChange),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
