import 'package:error_fit/config/styles/decorations.dart';
import 'package:error_fit/config/styles/font_styles.dart';
import 'package:error_fit/core/buttons/border_button.dart';
import 'package:error_fit/core/buttons/button.dart';
import 'package:flutter/material.dart';

import '../resources/actions.dart';

class ConfirmDialog extends StatefulWidget {
  final String? title;
  final String? description;
  final String? cancelText;
  final String? confirmText;
  final VoidCallback? onCancelClick;
  final VoidCallback? onConfirmClick;

  const ConfirmDialog({
    super.key,
    this.title,
    this.description,
    this.cancelText,
    this.confirmText,
    this.onCancelClick,
    this.onConfirmClick,
  });

  @override
  State<ConfirmDialog> createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: Decorations.card,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          spacing: 10,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.title ?? "Confirm the action",
              textAlign: TextAlign.center,
              style: FontStyles.s18Primary5,
            ),
            Text(
              widget.description ?? "Are sure to take this action",
              textAlign: TextAlign.center,
              style: FontStyles.s14Primary704,
            ),
            const SizedBox(height: 4),
            Row(
              spacing: 16,
              children: [
                Expanded(
                  child: BorderButton(
                    text: widget.cancelText ?? "Cancel",
                    onClick: _onCancelClick,
                  ),
                ),
                Expanded(
                  child: Button(
                    text: widget.confirmText ?? "Confirm",
                    onClick: () => widget.onConfirmClick?.call(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onCancelClick() {
    if (widget.onCancelClick != null) {
      widget.onCancelClick?.call();
      return;
    }
    closeDialog();
  }
}
