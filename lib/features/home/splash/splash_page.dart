import 'package:error_fit/core/resources/screen_view.dart';
import 'package:error_fit/features/home/splash/splash_controller.dart';
import 'package:error_fit/features/home/splash/splash_mobile.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final control = SplashController();

  @override
  void initState() {
    control.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenView(
        mobile: SplashMobile(control: control),
        web: SplashMobile(control: control),
        tab: SplashMobile(control: control),
      ),
    );
  }
}
