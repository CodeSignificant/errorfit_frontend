import 'package:flutter/material.dart';

import 'landing_controller.dart';

class LandingWeb extends StatefulWidget {
  final LandingController control;
  const LandingWeb({super.key, required this.control});

  @override
  State<LandingWeb> createState() => _LandingWebState();
}

class _LandingWebState extends State<LandingWeb> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
