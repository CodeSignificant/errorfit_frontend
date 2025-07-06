import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'anim_button.dart';

class SvgIconButton extends StatelessWidget {
  final String path;
  final VoidCallback onClick;
  final Color? color;
  final double? height;
  final double? width;
  final double? size;
  final double padding;

  const SvgIconButton({
    super.key,
    required this.path,
    required this.onClick,
    this.color,
    this.height,
    this.width,
    this.size,
    this.padding = 4,
  });

  @override
  Widget build(BuildContext context) {
    return AnimButton(
      onClick: onClick,
      child: SizedBox(
        height: size ?? height ?? 32,
        width: size ?? width ?? 32,
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: SvgPicture.asset(
            path.endsWith(".svg") ? path : "assets/icons/$path.svg",
            colorFilter: color != null
                ? ColorFilter.mode(color!, BlendMode.srcIn)
                : null,
          ),
        ),
      ),
    );
  }
}
