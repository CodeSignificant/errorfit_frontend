import 'package:error_fit/core/resources/screen_view.dart';
import 'package:error_fit/features/home/main/home_controller.dart';
import 'package:error_fit/features/home/main/home_mobile.dart';
import 'package:error_fit/features/home/main/home_tab.dart';
import 'package:error_fit/features/home/main/home_web.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String? tab;
  const HomePage({super.key, this.tab});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final control = HomeController();

  @override
  void initState() {
    control.init(tab: widget.tab);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenView(
        mobile: HomeMobile(control: control),
        tab: HomeTab(control: control),
        web: HomeWeb(control: control),
      ),
    );
  }
}
