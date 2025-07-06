import 'package:flutter/material.dart';

import 'landing_controller.dart';

class LandingTab extends StatefulWidget {
  final LandingController control;

  const LandingTab({super.key, required this.control});

  @override
  State<LandingTab> createState() => _LandingTabState();
}

class _LandingTabState extends State<LandingTab> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
