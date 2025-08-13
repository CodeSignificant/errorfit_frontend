import 'package:error_fit/config/styles/decorations.dart';
import 'package:error_fit/config/styles/font_styles.dart';
import 'package:error_fit/core/app_bars/toast.dart';
import 'package:error_fit/core/buttons/button.dart';
import 'package:error_fit/core/edit_texts/edit_text.dart';
import 'package:error_fit/core/network/repo/auth/auth_repo.dart';
import 'package:error_fit/core/resources/actions.dart';
import 'package:error_fit/core/resources/data_response.dart';
import 'package:error_fit/core/resources/validations.dart';
import 'package:error_fit/core/widgets/sheet_nob.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MailLoginSheetControl extends GetxController {
  final mailControl = TextEditingController();
  final isLoading = false.obs;
  final error = "".obs;
  Function(DataResponse response)? _onComplete;

  void setOnCompleteListener(Function(DataResponse response) listener) {
    _onComplete = listener;
  }

  void onLoginClick() async {
    error.value = "";
    if (!Validations.isValidEmail(mailControl.text)) {
      error.value = "Please enter a valid mail";
      return;
    }
    isLoading.value = true;
    final result = await AuthRepo.mailOTPLogin(
      mail: mailControl.text.trim().toLowerCase(),
    );
    isLoading.value = false;
    _onComplete?.call(result);
    if (result is DataSuccess) {
      Toast.success(
        title: "OTP sent successfully",
        message: "check your mail for OTP",
      );
      return;
    }
    if (result is DataFailed) {
      Toast.failed(title: "OTP sent failed", message: result.error);
      return;
    }
  }
}

class MailLoginSheet extends StatefulWidget {
  final Function(DataResponse response) onComplete;

  const MailLoginSheet({super.key, required this.onComplete});

  @override
  State<MailLoginSheet> createState() => _MailLoginSheetState();
}

class _MailLoginSheetState extends State<MailLoginSheet> {
  final control = MailLoginSheetControl();

  @override
  void initState() {
    control.setOnCompleteListener((response) => widget.onComplete(response));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Spacer(),
        Container(
          decoration: Decorations.sheet,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SheetNob(),
              const SizedBox(height: 26),
              Text(
                "Enter your mail for Login/Signup",
                style: FontStyles.s16Primary7,
              ),
              const SizedBox(height: 12),
              Obx(() {
                return EditText(
                  controller: control.mailControl,
                  error: control.error.value,
                  hint: "EMail",
                );
              }),
              const SizedBox(height: 16),
              Obx(() {
                return Button(
                  onClick: control.onLoginClick,
                  loading: control.isLoading.value,
                  text: "Login/Signup",
                );
              }),
              SizedBox(height: kBottomBarHeight),
            ],
          ),
        ),
      ],
    );
  }
}
