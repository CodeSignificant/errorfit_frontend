import 'package:flutter/material.dart';

import '../../config/styles/break_points.dart';

class ScreenView extends StatelessWidget {
  final Widget? mobile;
  final Widget? tab;
  final Widget? web;

  const ScreenView({super.key, this.mobile, this.tab, this.web});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < minScreen) return mobile ?? Container();
    if (screenWidth < tabScreen) return tab ?? Container();
    return web ?? Container();
  }
}
