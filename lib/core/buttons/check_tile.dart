import 'package:flutter/material.dart';

import '../../config/styles/font_styles.dart';
import '../images/svg_icon.dart';
import 'anim_button.dart';

class CheckTile extends StatelessWidget {
  final bool active;
  final String title;
  final VoidCallback onClick;

  const CheckTile({
    super.key,
    required this.active,
    required this.title,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return AnimButton(
      onClick: onClick,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgIcon(path: active ? "ic_check" : "ic_uncheck", size: 20,),
          const SizedBox(width: 8,),
          Text(title, style: FontStyles.s12Black4),
        ],
      ),
    );
  }
}
