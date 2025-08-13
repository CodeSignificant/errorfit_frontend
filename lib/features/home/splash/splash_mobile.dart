import 'dart:math';

import 'package:error_fit/config/environments/config.dart';
import 'package:error_fit/config/styles/font_styles.dart';
import 'package:error_fit/features/home/splash/splash_controller.dart';
import 'package:flutter/material.dart';

class SplashMobile extends StatefulWidget {
  final SplashController control;

  const SplashMobile({super.key, required this.control});

  @override
  State<SplashMobile> createState() => _SplashMobileState();
}

class _SplashMobileState extends State<SplashMobile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<StarLine> _starLines;
  late Size _screenSize;

  @override
  void initState() {
    super.initState();
    _starLines = [];
    _controller =
        AnimationController(
            vsync: this,
            duration: const Duration(seconds: 1), // doesn't matter: repeats
          )
          ..addListener(() {
            setState(() {
              _updateStarLines();
            });
          })
          ..repeat();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenSize = MediaQuery.of(context).size;
    // Create 200 star lines
    _starLines = List.generate(200, (_) => StarLine(_screenSize));
  }

  void _updateStarLines() {
    for (final line in _starLines) {
      line.update(_screenSize);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF343434),
      body: Stack(
        children: [
          CustomPaint(
            size: _screenSize,
            painter: StarLinesPainter(_starLines),
            child: SizedBox.expand(),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/logos/logo_errorfit.png",
                  width: 100,
                  height: 100,
                ),

                const SizedBox(height: 12),
                Text(Config.appName, style: FontStyles.s24White7),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Represents a single falling star line, like in the JS code
class StarLine {
  double x = 0;
  double y = 0;
  double length = 0;
  double speed = 0;
  double opacity = 1;

  StarLine(Size size) {
    reset(size);
  }

  void reset(Size size) {
    final rand = Random();
    x = rand.nextDouble() * size.width;
    y = (rand.nextDouble() * (size.height * 0.9)) - 400;
    length = 10 + rand.nextDouble() * 20;
    speed = 0.5 + rand.nextDouble() * 5;
    opacity = 0.4 + rand.nextDouble() * 0.3;
  }

  void update(Size size) {
    y += speed;
    if (y > size.height) {
      reset(size);
    }
  }
}

class StarLinesPainter extends CustomPainter {
  final List<StarLine> lines;

  StarLinesPainter(this.lines);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    for (final line in lines) {
      paint.color = Color.fromRGBO(245, 245, 245, line.opacity);
      canvas.drawLine(
        Offset(line.x, line.y),
        Offset(line.x, line.y + line.length),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
