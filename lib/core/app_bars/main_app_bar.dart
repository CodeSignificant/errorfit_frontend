import 'package:error_fit/config/styles/app_colors.dart';
import 'package:error_fit/core/images/svg_icon.dart';
import 'package:error_fit/core/resources/actions.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget {
  final Color background;
  const MainAppBar({super.key, this.background = AppColors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      // constraints: BoxConstraints(minHeight: 70),
      height: kToolbarHeight + kStatusBarHeight,
      color: background,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: kStatusBarHeight,),
          Row(
            children: [
              const SizedBox(width: 12,),
              Image.asset("assets/logos/img_ef_banner.png", width: 80, height: 36,),
              const Spacer(),
              SvgIcon(path: "ic_notification"),
              const SizedBox(width: 16,)
            ],
          ),
        ],
      ),
    );
  }
}
