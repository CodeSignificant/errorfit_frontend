import 'package:flutter/material.dart';

import 'svg_icon_button.dart';

class CheckButton extends StatelessWidget {
  final bool isActive;
  final Function(bool isActive) onClick;
  final double? size;

  const CheckButton({
    super.key,
    required this.isActive,
    required this.onClick,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SvgIconButton(
      size: size,
      path: isActive ? "ic_check" : "ic_uncheck",
      onClick: () => onClick(!isActive),
    );
  }
}
