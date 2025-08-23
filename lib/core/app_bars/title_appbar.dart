import 'package:error_fit/config/routes/routers.dart';
import 'package:error_fit/config/styles/app_colors.dart';
import 'package:error_fit/config/styles/font_styles.dart';
import 'package:error_fit/core/buttons/svg_icon_button.dart';
import 'package:error_fit/core/resources/actions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: kStatusBarHeight),
          Row(
            children: [
              const SizedBox(width: 12),
              // MyBackButton(),
              SvgIconButton(
                path: "ic_ios_left",
                size: 24,
                onClick: () => Get.back(),
              ),
              const SizedBox(width: 12),
              Text(title, style: FontStyles.s14Black4),
              const Spacer(),
              SvgIconButton(
                onClick: _onTileIconClick,
                path: "ic_cart",
                color: AppColors.primary,
              ),
              const SizedBox(width: 16),
            ],
          ),
        ],
      ),
    );
  }

  void _onTileIconClick() {
    homeRoute.queryParam("tab", "cart").navigate;
  }
}
