import 'package:flutter/material.dart';

import '../../config/styles/app_colors.dart';
import '../../config/styles/font_styles.dart';
import 'anim_button.dart';

class BorderButton extends StatelessWidget {
  final String text;
  final VoidCallback onClick;
  final EdgeInsets? padding;
  final TextStyle? style;
  final bool loading;
  final bool disable;
  final Color background;
  final Color color;
  final double radius;
  final double? minWidth;

  const BorderButton({
    super.key,
    required this.text,
    required this.onClick,
    this.padding,
    this.style,
    this.loading = false,
    this.background = AppColors.transparent,
    this.radius = 15,
    this.disable = false,
    this.minWidth,
    this.color = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return AnimButton(
      onClick: (loading || disable) ? () {} : onClick,
      child: Container(
        constraints:
            minWidth != null ? BoxConstraints(minWidth: minWidth!) : null,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: background,
          border: Border.all(color: color),
        ),

        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            loading
                ? Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: CircularProgressIndicator(
                    // size: (style?.fontSize ?? 14),
                    color: AppColors.white,
                  ),
                )
                : Text(
                  text,
                  textAlign: TextAlign.center,
                  style: style ?? FontStyles.s14Primary6,
                ),
          ],
        ),
      ),
    );
  }
}
