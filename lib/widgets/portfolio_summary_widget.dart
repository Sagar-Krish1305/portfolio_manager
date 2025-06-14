import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_manager/colors.dart';
import 'package:portfolio_manager/widgets/gradient_text.dart';
import 'package:portfolio_manager/widgets/time_filter_row.dart';

class PortfolioSummaryWidget extends StatefulWidget {
  const PortfolioSummaryWidget({super.key});

  @override
  State<PortfolioSummaryWidget> createState() => _PortfolioSummaryWidgetState();
}

class _PortfolioSummaryWidgetState extends State<PortfolioSummaryWidget> {
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
            const Text('Total Portfolio Value',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )),
            const GradientText(
              text: "₹74,560",
              style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
              gradient: LinearGradient(
                colors: [kProfitColor, kPrimaryCyan], // teal to cyan
              ),
            ),
            const GradientText(
              text: "+₹3012 Today",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              gradient: LinearGradient(
                colors: [kProfitColor, kProfitColor], // teal to cyan
              ),
            ),
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 150,
                    width: 300, // or MediaQuery.of(context).size.width * 0.8
                    child: LineChart(LineChartData(
                      lineBarsData: [
                        LineChartBarData(
                          spots: const [
                            FlSpot(0, 10),
                            FlSpot(1, 12),
                            FlSpot(2, 11),
                            FlSpot(3, 14),
                            FlSpot(4, 13),
                            FlSpot(5, 15),
                            FlSpot(6, 18),
                            FlSpot(7, 17),
                            FlSpot(8, 19),
                            FlSpot(9, 20),
                            FlSpot(10, 22),
                            FlSpot(11, 21),
                            FlSpot(12, 23),
                            FlSpot(13, 25),
                            FlSpot(14, 26),
                            FlSpot(15, 28),
                            FlSpot(16, 27),
                            FlSpot(17, 29),
                            FlSpot(18, 30),
                            FlSpot(19, 32),
                            FlSpot(20, 34),
                            FlSpot(21, 33),
                            FlSpot(22, 36),
                            FlSpot(23, 35),
                            FlSpot(24, 38),
                            FlSpot(25, 37),
                            FlSpot(26, 40),
                            FlSpot(27, 42),
                            FlSpot(28, 41),
                            FlSpot(29, 44),
                            FlSpot(30, 46),
                            FlSpot(31, 45),
                            FlSpot(32, 47),
                            FlSpot(33, 49),
                            FlSpot(34, 48),
                            FlSpot(35, 50),
                            FlSpot(36, 52),
                            FlSpot(37, 51),
                            FlSpot(38, 53),
                            FlSpot(39, 55),
                            FlSpot(40, 57),
                            FlSpot(41, 56),
                            FlSpot(42, 58),
                            FlSpot(43, 60),
                            FlSpot(44, 62),
                            FlSpot(45, 61),
                            FlSpot(46, 63),
                            FlSpot(47, 65),
                            FlSpot(48, 66),
                            FlSpot(49, 68),
                          ],
                          isCurved: true,
                          color: Colors.transparent, // don't use solid color
                          gradient: const LinearGradient(
                            // gradient for the line
                            colors: [
                              kProfitColor,
                              kPrimaryCyan,
                            ],
                          ),
                          belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              colors: [
                                kProfitColor.withAlpha(50), // semi-transparent
                                kPrimaryCyan.withAlpha(10), // fully transparent
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          shadow: const Shadow(
                            // <-- Drop shadow of the line itself
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
                  TimeFilterRow(onSelected: (String value) {})
                ],
              ),
            )
          ],
        ));
  }
}
