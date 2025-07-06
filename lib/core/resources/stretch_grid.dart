import 'package:flutter/material.dart';

class StretchGrid extends StatelessWidget {
  final List<Widget> children;
  final int crossAxisCount;
  final double spacing;

  const StretchGrid({
    super.key,
    required this.children,
    this.crossAxisCount = 2,
    this.spacing = 12,
  });

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];

    for (int i = 0; i < children.length; i += crossAxisCount) {
      final rowChildren = children.skip(i).take(crossAxisCount).toList();

      // Add empty widgets to fill the row if needed
      while (rowChildren.length < crossAxisCount) {
        rowChildren.add(const SizedBox());
      }

      rows.add(
        Row(
          children: List.generate(rowChildren.length, (index) {
            final isLast = index == rowChildren.length - 1;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: isLast ? 0 : spacing),
                child: rowChildren[index],
              ),
            );
          }),
        ),
      );

      // Add vertical spacing between rows
      if (i + crossAxisCount < children.length) {
        rows.add(SizedBox(height: spacing));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows,
    );
  }
}
