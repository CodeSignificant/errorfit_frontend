import 'package:flutter/material.dart';

class SlideUpRightAnim extends StatefulWidget {
  final Widget child;

  const SlideUpRightAnim({super.key, required this.child});

  @override
  State<SlideUpRightAnim> createState() => _SlideUpRightAnimState();
}

class _SlideUpRightAnimState extends State<SlideUpRightAnim>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset(0.2, 0.2), // slightly more movement
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            _offsetAnimation.value.dx * 100, // Adjust multiplier if needed
            _offsetAnimation.value.dy * 100,
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
