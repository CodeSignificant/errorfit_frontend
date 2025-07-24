import 'package:error_fit/config/styles/app_colors.dart';
import 'package:error_fit/core/images/svg_icon.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget {
  final Color background;
  const MainAppBar({super.key, this.background = AppColors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      // constraints: BoxConstraints(minHeight: 70),
      color: background,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgIcon(path: "ic_menu"),
          SvgIcon(path: "ic_notification"),
        ],
      ),
    );
  }
}
