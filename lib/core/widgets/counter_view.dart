import 'package:error_fit/config/styles/font_styles.dart';
import 'package:error_fit/core/buttons/svg_icon_button.dart';
import 'package:flutter/material.dart';

class CounterView extends StatelessWidget {
  final int value;
  final Function(int value) onIncrement;
  final Function(int value) onDecrement;

  const CounterView({
    super.key,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgIconButton(
          path: "ic_minus_button",
          onClick: () => onDecrement(value - 1),
        ),
        const SizedBox(width: 8),
        Text("$value", style: FontStyles.s22Primary707),
        const SizedBox(width: 8),
        SvgIconButton(
          path: "ic_plus_button",
          onClick: () => onIncrement(value + 1),
        ),
      ],
    );
  }
}
