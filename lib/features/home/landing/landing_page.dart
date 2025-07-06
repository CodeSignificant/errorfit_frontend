import 'package:error_fit/features/home/landing/landing_controller.dart';
import 'package:error_fit/features/home/landing/landing_mobile.dart';
import 'package:error_fit/features/home/landing/landing_tab.dart';
import 'package:error_fit/features/home/landing/landing_web.dart';
import 'package:flutter/material.dart';

import '../../../../core/resources/screen_view.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final control = LandingController();

  @override
  void initState() {
    control.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenView(
        mobile: LandingMobile(control: control),
        tab: LandingTab(control: control),
        web: LandingWeb(control: control),
      ),
    );
  }
}
