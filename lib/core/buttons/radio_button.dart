
import 'package:flutter/material.dart';

import 'svg_icon_button.dart';

class RadioButton extends StatelessWidget {
  final bool isActive;
  final Function(bool isActive) onClick;

  const RadioButton({super.key, required this.isActive, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return SvgIconButton(
      path: isActive ? "ic_active_radio" : "ic_inactive_radio",
      onClick: () => onClick(!isActive),
    );
  }
}
