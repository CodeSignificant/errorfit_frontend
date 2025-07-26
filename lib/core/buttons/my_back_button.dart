import 'package:error_fit/config/styles/app_colors.dart';
import 'package:error_fit/config/styles/decorations.dart';
import 'package:error_fit/core/buttons/anim_button.dart';
import 'package:error_fit/core/images/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyBackButton extends StatelessWidget {
  final VoidCallback? onClick;

  const MyBackButton({super.key, this.onClick});

  @override
  Widget build(BuildContext context) {
    return AnimButton(
      onClick: _onBackClick,
      child: Container(
        decoration: Decorations.card.copyWith(
          borderRadius: BorderRadius.circular(100),
        ),
        padding: const EdgeInsets.all(10),
        child: SvgIcon(
          path: "ic_ios_arrow",
          size: 14,
          color: AppColors.primary,
        ),
      ),
    );
  }

  void _onBackClick() {
    if (onClick == null) Get.back();
    onClick?.call();
  }
}
