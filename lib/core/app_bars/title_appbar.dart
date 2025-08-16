import 'package:error_fit/config/styles/app_colors.dart';
import 'package:error_fit/config/styles/font_styles.dart';
import 'package:error_fit/core/buttons/my_back_button.dart';
import 'package:error_fit/core/images/svg_icon.dart';
import 'package:error_fit/core/resources/actions.dart';
import 'package:flutter/material.dart';

class TitleAppBar extends StatelessWidget {
  final String title;
  final Color background;

  const TitleAppBar({
    super.key,
    required this.title,
    this.background = AppColors.white,
  });

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
          SizedBox(height: kStatusBarHeight),
          Row(
            children: [
              const SizedBox(width: 12),
              MyBackButton(),
              const SizedBox(width: 12),
              Text(title, style: FontStyles.s14Black4),
              const Spacer(),
              SvgIcon(path: "ic_notification"),
              const SizedBox(width: 16),
            ],
          ),
        ],
      ),
    );
  }
}
