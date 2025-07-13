import 'package:error_fit/features/home/landing/landing_controller.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/my_carousel.dart';

class LandingMobile extends StatefulWidget {
  final LandingController control;
  const LandingMobile({super.key, required this.control});

  @override
  State<LandingMobile> createState() => _LandingMobileState();
}

class _LandingMobileState extends State<LandingMobile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MyCarousel(
          autoScrollDuration: Duration(seconds: 4),
          items: [
            ColoredBox(color: Colors.red,
                child: Center(child: Text("Slide 1",
                    style: TextStyle(color: Colors.white, fontSize: 24)))),
            ColoredBox(color: Colors.green,
                child: Center(child: Text("Slide 2",
                    style: TextStyle(color: Colors.white, fontSize: 24)))),
            ColoredBox(color: Colors.blue,
                child: Center(child: Text("Slide 3",
                    style: TextStyle(color: Colors.white, fontSize: 24)))),
          ],
        ),
      ],
    );
  }
}
