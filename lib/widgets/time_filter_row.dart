import 'package:flutter/material.dart';
import 'package:portfolio_manager/colors.dart';

class TimeFilterRow extends StatefulWidget {
  final Function(String) onSelected;
  const TimeFilterRow({super.key, required this.onSelected});

  @override
  State<TimeFilterRow> createState() => _TimeFilterRowState();
}

class _TimeFilterRowState extends State<TimeFilterRow> {
  final List<String> filters = ['1D', '1W', '1M', '3M', '1Y', 'ALL'];
  String selected = 'ALL';

  void selectFilter(String label) {
    setState(() {
      selected = label;
    });
    widget.onSelected(label);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: filters.map((label) {
        final isSelected = selected == label;
        return GestureDetector(
          onTap: () => selectFilter(label),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              gradient: isSelected ? kAmountGradient : null,
              color: isSelected ? null : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.transparent,
                width: 1,
              ),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? kCardBackground : kTextMuted,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
