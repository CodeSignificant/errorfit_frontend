import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../config/styles/app_colors.dart';
import '../../config/styles/font_styles.dart';
import '../images/svg_icon.dart';

class EditText extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final double radius;
  final bool isPassword;
  final bool isDisable;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final TextInputType? keyboardType;
  final List<String>? autofillHints;
  final String error;
  final String? label;
  final bool mandatory;
  final Function(String value)? onSubmit;
  final TextInputAction? textInputAction;
  final String? prefixIcon;
  final double? iconSize;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final int? maxLength;
  final FocusNode? focusNode;

  const EditText({
    super.key,
    required this.controller,
    required this.hint,
    this.radius = 48,
    this.isPassword = false,
    this.isDisable = false,
    this.style,
    this.hintStyle,
    this.keyboardType,
    this.autofillHints,
    this.error = "",
    this.onSubmit,
    this.textInputAction,
    this.label,
    this.mandatory = true,
    this.prefixIcon,
    this.iconSize,
    this.inputFormatters,
    this.maxLines, this.focusNode, this.maxLength, // ✅ Constructor updated
  });

  @override
  State<EditText> createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  final RxBool _passwordVisible = false.obs;

  @override
  Widget build(BuildContext context) {
    final hasError = widget.error.isNotEmpty;
    return Opacity(
      opacity: widget.isDisable ? 0.6 : 1.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.label != null)
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "${widget.label} ",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.accent,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  if (widget.mandatory)
                    TextSpan(
                      text: "*",
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  if (!widget.mandatory)
                    TextSpan(
                      text: "(optional)",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                ],
              ),
            ),
          if (widget.label != null) const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(
                color: hasError ? AppColors.error : AppColors.primary,
              ),
              borderRadius: BorderRadius.circular(widget.radius),
            ),
            constraints: const BoxConstraints(maxWidth: 450),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Obx(() {
              final bool passVisible = _passwordVisible.value;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                // Support multiline
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: widget.controller,
                      obscureText: widget.isPassword ? !passVisible : false,
                      style: widget.style ?? FontStyles.s14RBlack,
                      keyboardType: widget.keyboardType,
                      autofillHints: widget.autofillHints,
                      enabled: !widget.isDisable,
                      onFieldSubmitted: widget.onSubmit,
                      textInputAction: widget.textInputAction,
                      inputFormatters: widget.inputFormatters,
                      maxLines: widget.maxLines ?? 1,
                      focusNode: widget.focusNode,
                      // ✅ Use maxLines
                      decoration: InputDecoration(
                        isCollapsed: true,
                        border: InputBorder.none,
                        hintText: widget.hint,
                        hintStyle: widget.hintStyle ?? FontStyles.s12Grey,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  if (widget.isPassword)
                    GestureDetector(
                      onTap: _passwordVisible.toggle,
                      child: Icon(
                        passVisible ? Icons.visibility : Icons.visibility_off,
                        size: 20,
                        color: Colors.grey,
                      ),
                    ),
                  if (widget.prefixIcon != null)
                    SvgIcon(path: widget.prefixIcon!, size: widget.iconSize),
                ],
              );
            }),
          ),
          if (hasError)
            Padding(
              padding: const EdgeInsets.only(left: 4.0, top: 4.0),
              child: Text(widget.error, style: FontStyles.error),
            ),
        ],
      ),
    );
  }
}
