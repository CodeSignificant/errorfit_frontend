import 'package:flutter/material.dart';
import '../../config/styles/app_colors.dart';
import '../../config/styles/font_styles.dart';
import 'anim_button.dart';

class Button extends StatelessWidget {
  final VoidCallback onClick;
  final String text;
  final EdgeInsets? padding;
  final TextStyle? style;
  final bool loading;
  final bool disable;
  final Color background;
  final double radius;
  final double? minWidth;
  final TextStyle? hintStyle;

  const Button(
      {super.key,
      required this.onClick,
      required this.text,
      this.padding,
      this.style,
      this.loading = false,
      this.background = AppColors.primary,
      this.radius = 100,
      this.disable = false,
      this.minWidth,
      this.hintStyle});

  @override
  Widget build(BuildContext context) {
    return AnimButton(
      onClick: (loading || disable) ? () {} : onClick,
      child: Container(
        constraints:
            minWidth != null ? BoxConstraints(minWidth: minWidth!) : null,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius), color: background),
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            loading
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 26, vertical: 4),
                    child: SizedBox(
                      width: (style?.fontSize ?? 14),
                      height: (style?.fontSize ?? 14),
                      child: const CircularProgressIndicator(
                        color: AppColors.white,
                        strokeWidth: 2,
                      ),
                    ),
                  )
                : Text(
                    text,
                    textAlign: TextAlign.center,
                    style: style ?? FontStyles.s14RWhite,
                  ),
          ],
        ),
      ),
    );
  }
}
