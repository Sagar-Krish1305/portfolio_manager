import 'package:flutter/material.dart';
import 'package:portfolio_manager/colors.dart';
import 'package:portfolio_manager/widgets/portfolio_risk_level_card.dart';
import 'package:portfolio_manager/widgets/risk_by_stock_widget.dart';
import 'package:portfolio_manager/widgets/speed_dial.dart';

class RiskAnalysisPage extends StatefulWidget {
  const RiskAnalysisPage({super.key});

  @override
  State<RiskAnalysisPage> createState() => _RiskAnalysisPageState();
}

class _RiskAnalysisPageState extends State<RiskAnalysisPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(
          children: [
            const PortfolioRiskLevelCard(),
            const SizedBox(height: 16),
            Container(
                padding: const EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                  color: kCardBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const RiskByStockWidget())
          ],
        )),
      ),
      floatingActionButton:
          const SpeedDialWidget(currentRoute: '/risk_analysis'),
    );
  }
}
