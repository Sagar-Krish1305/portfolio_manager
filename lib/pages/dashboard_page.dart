import 'package:flutter/material.dart';
import 'package:portfolio_manager/colors.dart';
import 'package:portfolio_manager/widgets/holdings_widget.dart';
import 'package:portfolio_manager/widgets/portfolio_summary_widget.dart';
import 'package:portfolio_manager/widgets/speed_dial.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Future<void> _refresh() async {
    // You can call a method in PortfolioProvider or manually reload the data
    print('Refreshing dashboard...');
    await Future.delayed(const Duration(seconds: 1)); // Simulate delay
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refresh,
          color: kPrimaryCyan,
          backgroundColor: kCardBackground,
          child: SingleChildScrollView(
            physics:
                const AlwaysScrollableScrollPhysics(), // required for RefreshIndicator to work
            padding: const EdgeInsets.all(16),
            child: const Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PortfolioSummaryWidget(),
                  SizedBox(height: 16),
                  HoldingsWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: const SpeedDialWidget(currentRoute: '/dashboard'),
    );
  }
}
