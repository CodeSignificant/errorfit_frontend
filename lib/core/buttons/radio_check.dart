
import 'package:error_fit/config/styles/app_colors.dart';
import 'package:flutter/material.dart';

import 'svg_icon_button.dart';

class RadioCheck extends StatelessWidget {
  final bool isActive;
  final Function(bool isActive) onClick;
  final double? size;

  const RadioCheck(
      {super.key, required this.isActive, required this.onClick, this.size});

  @override
  Widget build(BuildContext context) {
    return SvgIconButton(
      size: size,
      path: isActive ? "ic_radio_tick" : "ic_radio_uncheck",
      color: AppColors.primary70,
      onClick: () => onClick(!isActive),
    );
  }
}
