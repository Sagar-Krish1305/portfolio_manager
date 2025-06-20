import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
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
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Center(
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
      floatingActionButton: SpeedDialWidget(currentRoute: '/dashboard'),
    );
  }
}
