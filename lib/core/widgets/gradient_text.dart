import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final TextStyle? style;
  final double? size;
  final List<Color>? colors;

  const GradientText(this.text, {super.key, this.textAlign, this.style, this.size, this.colors});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback:
          (bounds) => LinearGradient(
            colors: colors??[Color(0xffff2483), Color(0xffffbf46), Color(0xfffb0f01)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: Text(
        text,
        textAlign: textAlign,
        style:
            style ??
            TextStyle(
              fontSize: size??18,
              height: 1,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
      ),
    );
  }
}
