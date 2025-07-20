import 'package:error_fit/core/images/svg_icon.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgIcon(path: "ic_menu"),
        SvgIcon(path: "ic_notification"),
      ],
    );
  }
}
