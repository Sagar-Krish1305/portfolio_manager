import 'package:flutter/material.dart';
import 'package:portfolio_manager/colors.dart';
import 'package:portfolio_manager/widgets/gradient_text.dart';
import 'package:portfolio_manager/widgets/holding_tile.dart';

class ExpandableListViewer<T> extends StatefulWidget {
  final List<T> tiles;
  final int previewCount;
  const ExpandableListViewer({
    super.key,
    required this.tiles,
    this.previewCount = 3,
  });

  @override
  State<ExpandableListViewer> createState() => _ExpandableListViewerState();
}

class _ExpandableListViewerState extends State<ExpandableListViewer> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final visibleItems = isExpanded
        ? widget.tiles
        : widget.tiles.take(widget.previewCount).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: visibleItems.length,
          itemBuilder: (context, index) {
            return widget.tiles[index];
          },
        ),
        const SizedBox(height: 8),
        TextButton(
            onPressed: () {
              setState(() => isExpanded = !isExpanded);
            },
            child: GradientText(
                text: (isExpanded ? 'Show Less' : 'View All'),
                gradient:
                    const LinearGradient(colors: [kProfitColor, kPrimaryCyan]),
                style: const TextStyle(fontSize: 16))),
      ],
    );
  }
}
