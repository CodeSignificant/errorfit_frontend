import 'package:flutter/material.dart';

import '../../config/styles/break_points.dart';

class CenterMin extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  const CenterMin({super.key, required this.child, this.padding, this.margin});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: padding,
        margin: margin,
        constraints: const BoxConstraints(maxWidth: minScreen),
        child: child,
      ),
    );
  }
}
