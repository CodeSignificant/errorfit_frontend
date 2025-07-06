import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  final String path;
  final Color? color;
  final double? height;
  final double? width;
  final double? size;
  final BoxFit? fit;

  const SvgIcon({
    super.key,
    required this.path,
    this.color,
    this.height,
    this.width,
    this.size,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size ?? height ?? 24,
      width: size ?? width ?? 24,
      child: SvgPicture.asset(
        path.endsWith(".svg") ? path : "assets/icons/$path.svg",
        fit: fit ?? BoxFit.contain,
        height: size ?? height ?? 24,
        width: size ?? width ?? 24,
        colorFilter:
            color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      ),
    );
  }
}
