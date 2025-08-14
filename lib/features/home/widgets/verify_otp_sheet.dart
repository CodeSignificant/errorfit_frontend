import 'package:error_fit/core/resources/data_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../config/styles/decorations.dart';
import '../../../config/styles/font_styles.dart';
import '../../../core/app_bars/toast.dart';
import '../../../core/buttons/button.dart';
import '../../../core/edit_texts/edit_text.dart';
import '../../../core/network/repo/auth/auth_repo.dart';
import '../../../core/resources/actions.dart';
import '../../../core/widgets/sheet_nob.dart';

class VerifyOTPControl extends GetxController {
  final otpControl = TextEditingController();
  final isLoading = false.obs;
  final error = "".obs;
  Function(DataResponse response)? _onComplete;

  void setOnCompleteListener(Function(DataResponse response) listener) {
    _onComplete = listener;
  }

  void onVerifyClick({required String token}) async {
    error.value = "";
    if (otpControl.text.trim().length != 6) {
      error.value = "Please enter a full otp";
      return;
    }
    isLoading.value = true;
    final result = await AuthRepo.verifyOTP(
      otp: otpControl.text.trim(),
      token: token,
    );
    isLoading.value = false;
    _onComplete?.call(result);
    if (result is DataSuccess) {
      Toast.success(
        title: "Login successfully",
        message: "welcome to the ErrorFit",
      );
      return;
    }
    if (result is DataFailed) {
      error.value = result.error;
      Toast.failed(title: "Login failed", message: result.error);
      return;
    }
  }
}

class VerifyOTPSheet extends StatefulWidget {
  final String title;
  final String hint;
  final String token;
  final Function(DataResponse response) onComplete;

  const VerifyOTPSheet({
    super.key,
    required this.title,
    required this.hint,
    required this.token,
    required this.onComplete,
  });

  @override
  State<VerifyOTPSheet> createState() => _VerifyOTPSheetState();
}

class _VerifyOTPSheetState extends State<VerifyOTPSheet> {
  final control = VerifyOTPControl();

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
              Text(widget.title, style: FontStyles.s16Primary7),
              const SizedBox(height: 2),
              Text(widget.hint, style: FontStyles.s14Primary705),
              const SizedBox(height: 14),
              Obx(() {
                return EditText(
                  controller: control.otpControl,
                  hint: "OTP",
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.go,
                  isPassword: true,
                  error: control.error.value,
                  textAlign: TextAlign.center,
                  maxLength: 6,
                );
              }),
              const SizedBox(height: 16),
              Obx(() {
                return Button(
                  onClick: () => control.onVerifyClick(token: widget.token),
                  loading: control.isLoading.value,
                  text: "Verify",
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
