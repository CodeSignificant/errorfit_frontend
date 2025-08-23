import 'package:error_fit/core/resources/screen_view.dart';
import 'package:error_fit/features/support/main/support_controller.dart';
import 'package:error_fit/features/support/main/support_mobile_view.dart';
import 'package:flutter/material.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  final control = SupportController();

  @override
  void initState() {
    control.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenView(mobile: SupportMobileView(control: control)),
    );
  }
}
