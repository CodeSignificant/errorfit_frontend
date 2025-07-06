import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class DottedLine extends StatelessWidget {
  final Widget child;
  final double radius;
  final double gap;
  final double dotWidth;
  final double strokeWidth;
  final Color color;

  const DottedLine({
    super.key,
    required this.child,
    this.radius = 12.0,
    this.gap = 6.0,
    this.dotWidth = 8.0,
    this.strokeWidth = 1.5,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DottedBorderPainter(
        radius: radius,
        gap: gap,
        dotWidth: dotWidth,
        strokeWidth: strokeWidth,
        color: color,
      ),
      child: Padding(padding: EdgeInsets.all(radius), child: child),
    );
  }
}

class _DottedBorderPainter extends CustomPainter {
  final double radius;
  final double gap;
  final double dotWidth;
  final double strokeWidth;
  final Color color;

  _DottedBorderPainter({
    required this.radius,
    required this.gap,
    required this.dotWidth,
    required this.strokeWidth,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(radius)),
      );

    final ui.PathMetrics metrics = path.computeMetrics();
    final dotted = Path();

    for (final ui.PathMetric metric in metrics) {
      double distance = 0.0;
      while (distance < metric.length) {
        final double end = distance + dotWidth;
        dotted.addPath(metric.extractPath(distance, end), Offset.zero);
        distance += dotWidth + gap;
      }
    }

    canvas.drawPath(dotted, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
