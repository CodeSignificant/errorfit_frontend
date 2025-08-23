import 'package:error_fit/config/styles/font_styles.dart';
import 'package:error_fit/core/app_bars/title_appbar.dart';
import 'package:error_fit/core/buttons/button.dart';
import 'package:error_fit/core/edit_texts/edit_text.dart';
import 'package:error_fit/features/support/main/support_controller.dart';
import 'package:flutter/material.dart';

class SupportMobileView extends StatefulWidget {
  final SupportController control;

  const SupportMobileView({super.key, required this.control});

  @override
  State<SupportMobileView> createState() => _SupportMobileViewState();
}

class _SupportMobileViewState extends State<SupportMobileView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TitleAppBar(title: "Support"),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 26),
                Text(
                  "Please send you inconvenience here, we will resolve as soon as possible",
                  style: FontStyles.s16Primary7,
                ),
                const SizedBox(height: 16),
                EditText(
                  controller: widget.control.messageControl,
                  hint: "Enter message here to describe your issue more clearly",
                  maxLines: 5,
                  maxLength: 200,
                  radius: 8,
                ),
                const SizedBox(height: 26),
                Button(onClick: widget.control.onSubmitClick, text: "Submit"),
                const SizedBox(height: 26),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
