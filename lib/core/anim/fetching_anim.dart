import 'package:flutter/material.dart';

import '../../config/styles/app_colors.dart';

class FetchingAnim extends StatefulWidget {
  /// Height of the bouncing loader
  final double height;

  /// Color of the bar
  final Color color;

  /// Background color of the container
  final Color backgroundColor;

  /// Padding around the loader
  final EdgeInsetsGeometry padding;

  /// Width fraction of the bouncing bar (0..1)
  final double barWidthFraction;

  /// Duration of one full bounce
  final Duration duration;

  const FetchingAnim({
    super.key,
    this.height = 4,
    this.color = AppColors.primary,
    this.backgroundColor = Colors.transparent,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    this.barWidthFraction = 0.25,
    this.duration = const Duration(milliseconds: 1200),
  });

  @override
  State<FetchingAnim> createState() => _FetchingAnimState();
}

class _FetchingAnimState extends State<FetchingAnim>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat(reverse: true);

    // Ease-in-out curve makes it slow at edges, fast in center
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final parentWidth = constraints.maxWidth;
          final barWidth = parentWidth * widget.barWidthFraction;

          return Stack(
            children: [
              // Background container
              Container(
                width: parentWidth,
                height: widget.height,
                decoration: BoxDecoration(
                  color: widget.backgroundColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(widget.height / 2),
                ),
              ),
              // Animated bouncing bar
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  // left position changes with easing
                  final left = (parentWidth - barWidth) * _animation.value;
                  return Positioned(
                    left: left,
                    child: Container(
                      width: barWidth,
                      height: widget.height,
                      decoration: BoxDecoration(
                        color: widget.color,
                        borderRadius: BorderRadius.circular(widget.height / 2),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
