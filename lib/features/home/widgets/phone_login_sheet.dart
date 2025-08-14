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
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PhoneLoginSheetControl extends GetxController {
  final phoneControl = TextEditingController();
  final isLoading = false.obs;
  final error = "".obs;
  Function(DataResponse response, String phone)? _onComplete;

  void setOnCompleteListener(
    Function(DataResponse response, String phone) listener,
  ) {
    _onComplete = listener;
  }

  void onLoginClick() async {
    error.value = "";
    if (!Validations.isValidIndianMobileNumber(phoneControl.text)) {
      error.value = "Please enter a valid phone";
      return;
    }
    isLoading.value = true;
    final result = await AuthRepo.phoneOTPLogin(
      phone: phoneControl.text.trim().toLowerCase(),
    );
    isLoading.value = false;
    _onComplete?.call(result, phoneControl.text.trim());
    if (result is DataSuccess) {
      Toast.success(
        title: "OTP sent successfully",
        message: "check your phone for OTP",
      );
      return;
    }
    if (result is DataFailed) {
      Toast.failed(title: "OTP sent failed", message: result.error);
      return;
    }
  }
}

class PhoneLoginSheet extends StatefulWidget {
  final Function(DataResponse response, String phone) onComplete;

  const PhoneLoginSheet({super.key, required this.onComplete});

  @override
  State<PhoneLoginSheet> createState() => _PhoneLoginSheetState();
}

class _PhoneLoginSheetState extends State<PhoneLoginSheet> {
  final control = PhoneLoginSheetControl();

  @override
  void initState() {
    control.setOnCompleteListener(
      (response, phone) => widget.onComplete(response, phone),
    );
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
                "Enter your phone for Login/Signup",
                style: FontStyles.s16Primary7,
              ),
              const SizedBox(height: 12),
              Obx(() {
                return EditText(
                  controller: control.phoneControl,
                  error: control.error.value,
                  hint: "Phone",
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  textInputAction: TextInputAction.go,
                  keyboardType: TextInputType.number,
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
