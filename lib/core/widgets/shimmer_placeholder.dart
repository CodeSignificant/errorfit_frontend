import 'package:flutter/material.dart';

enum ShimmerShape {
  circle,
  rectangle,
}

class ShimmerPlaceholder extends StatefulWidget {
  final double width;
  final double height;
  final ShimmerShape shape;
  final double borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  const ShimmerPlaceholder({
    super.key,
    required this.width,
    required this.height,
    this.shape = ShimmerShape.rectangle,
    this.borderRadius = 8.0, this.padding, this.margin,
  });

  @override
  State<ShimmerPlaceholder> createState() => _ShimmerPlaceholderState();
}

class _ShimmerPlaceholderState extends State<ShimmerPlaceholder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
    AnimationController(duration: const Duration(seconds: 2), vsync: this)
      ..repeat();
    _animation = Tween<double>(begin: -1, end: 2).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) {
        return ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.grey.shade300,
                Colors.grey.shade100,
                Colors.grey.shade300,
              ],
              stops: const [0.1, 0.5, 0.9],
              transform:
              SlidingGradientTransform(slidePercent: _animation.value),
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcATop,
          child: Container(
            width: widget.width,
            height: widget.height,
            padding: widget.padding,
            margin: widget.margin,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              shape: widget.shape == ShimmerShape.circle
                  ? BoxShape.circle
                  : BoxShape.rectangle,
              borderRadius: widget.shape == ShimmerShape.rectangle
                  ? BorderRadius.circular(widget.borderRadius)
                  : null,
            ),
          ),
        );
      },
    );
  }
}

class SlidingGradientTransform extends GradientTransform {
  final double slidePercent;

  const SlidingGradientTransform({required this.slidePercent});

  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}
