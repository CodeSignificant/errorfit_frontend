import 'package:error_fit/config/styles/decorations.dart';
import 'package:error_fit/core/buttons/anim_button.dart';
import 'package:error_fit/core/images/svg_icon.dart';
import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final String icon;
  final VoidCallback onClick;
  final double? size;

  const CircleButton({
    super.key,
    this.size = 14, required this.icon, required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return AnimButton(
      onClick: onClick,
      child: Container(
        decoration: Decorations.card.copyWith(
          borderRadius: BorderRadius.circular(100),
        ),
        padding: const EdgeInsets.all(10),
        child: SvgIcon(size: size, path: icon),
      ),
    );
  }
}
