import 'package:flutter/material.dart';
import 'package:portfolio_manager/colors.dart';

class RiskByStockWidget extends StatefulWidget {
  const RiskByStockWidget({super.key});

  @override
  State<RiskByStockWidget> createState() => _RiskByStockWidgetState();
}

class _RiskByStockWidgetState extends State<RiskByStockWidget> {
  bool _expanded = false;

  final List<Map<String, String>> _stockData = [
    {'stock': 'TSLA', 'allocation': '10%', 'volatility': '0.30', 'beta': '1.7'},
    {'stock': 'AAPL', 'allocation': '20%', 'volatility': '0.25', 'beta': '1.2'},
    {
      'stock': 'GOOGL',
      'allocation': '15%',
      'volatility': '0.18',
      'beta': '1.1'
    },
    {'stock': 'AMZN', 'allocation': '18%', 'volatility': '0.22', 'beta': '1.3'},
  ];

  static const int defaultVisibleCount = 3;

  @override
  Widget build(BuildContext context) {
    final bool shouldShowToggle = _stockData.length > defaultVisibleCount;
    final List<Map<String, String>> visibleData = _expanded || !shouldShowToggle
        ? _stockData
        : _stockData.take(defaultVisibleCount).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Risk By Stock',
          style: TextStyle(
            fontSize: 24,
            color: kTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        // Header Row
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: const Row(
            children: [
              Expanded(
                flex: 2,
                child: Text('Stock',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: kTextMuted)),
              ),
              Expanded(
                flex: 3,
                child: Text('Allocation',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: kTextMuted)),
              ),
              Expanded(
                flex: 3,
                child: Text('Volatility',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: kTextMuted)),
              ),
              Expanded(
                flex: 2,
                child: Text('Beta',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: kTextMuted)),
              ),
            ],
          ),
        ),

        // Data Rows
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: visibleData.length,
          itemBuilder: (context, index) {
            final item = visibleData[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(item['stock']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: kTextColor)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(item['allocation']!,
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(fontSize: 18, color: kTextColor)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(item['volatility']!,
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(fontSize: 18, color: kTextColor)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(item['beta']!,
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(fontSize: 18, color: kTextColor)),
                  ),
                ],
              ),
            );
          },
        ),

        const SizedBox(height: 12),

        // Toggle only if more than 3 rows
        if (shouldShowToggle)
          Center(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              child: Text(
                _expanded ? 'Hide' : 'View All',
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
      ],
    );
  }
}
