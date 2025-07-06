import 'dart:async';

import 'package:flutter/material.dart';

class AnimButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onClick;
  final double shrinkScale;
  final bool disabled;
  final EdgeInsets padding;

  const AnimButton({
    super.key,
    required this.onClick,
    required this.child,
    this.shrinkScale = 0.97,
    this.disabled = false,
    this.padding = EdgeInsets.zero,
  });

  @override
  State<AnimButton> createState() => _AnimButtonState();
}

class _AnimButtonState extends State<AnimButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (widget.disabled == false) {
            _debounce();
          }
        },
        behavior: HitTestBehavior.translucent,
        onTapDown: (d) {
          if (widget.disabled == false) {
            _controller.forward();
          }
        },
        onTapUp: (d) {
          Future.delayed(const Duration(milliseconds: 110), () {
            if (widget.disabled == false) {
              _controller.reverse();
            }
          });
        },
        onTapCancel: () {
          Future.delayed(const Duration(milliseconds: 110), () {
            if (widget.disabled == false) {
              _controller.reverse();
            }
          });
        },
        child: ScaleTransition(
          scale: Tween<double>(
            begin: 1.0,
            end: widget.shrinkScale,
          ).animate(_controller),
          child: Padding(
            padding: widget.padding,
            child: widget.child,
          ),
        ),
      ),
    );
  }

  void _debounce() {
    if (_debounceTimer?.isActive ?? false) return;
    _debounceTimer = Timer(const Duration(milliseconds: 110), () {
      widget.onClick();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }
}
