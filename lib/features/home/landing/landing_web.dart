import 'package:error_fit/config/enums/login_types.dart';
import 'package:error_fit/config/extensions/string_extensions.dart';
import 'package:error_fit/core/images/ImageLoader.dart';
import 'package:error_fit/core/resources/center_min.dart';
import 'package:error_fit/features/home/widgets/login_types_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../config/styles/font_styles.dart';
import '../../../core/buttons/anim_button.dart';
import '../../../core/buttons/button.dart';
import '../../../core/edit_texts/edit_text.dart';
import 'landing_controller.dart';

class LandingWeb extends StatefulWidget {
  final LandingController control;

  const LandingWeb({super.key, required this.control});

  @override
  State<LandingWeb> createState() => _LandingWebState();
}

class _LandingWebState extends State<LandingWeb> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            child: ImageLoader(
              url: widget.control.landingWebImage.first.autoUrl,
              radius: 0,
              fit: BoxFit.cover,)),
        Expanded(
            child: CenterMin(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 26,),
                  Image.asset(
                    "assets/logos/img_ef_banner.png", height: 60,),
                  Flexible(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 26),
                        child: Obx(() {
                          if (widget.control.token.isNotEmpty) {
                            return _verifyOTP();
                          }
                          if (widget.control.activeLoginType.value ==
                              LoginTypes.phone) {
                            return _phoneLogin();
                          }
                          return _mailLogin();
                        }),
                      )),

                  LoginTypesRow(onSelect: widget.control.onLoginTypeClick),
                  SizedBox(height: 16,),
                  Center(child: AnimButton(
                      onClick: widget.control.onGuestClick,
                      child: Text("continue as a guest", style: FontStyles
                          .s14Primary6,))),
                  SizedBox(height: 16,),

                ],),
            ))
      ],
    );
  }


  Widget _phoneLogin() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [

        const SizedBox(height: 26),
        Text(
          "Enter your phone for Login/Signup",
          style: FontStyles.s16Primary7,
        ),
        const SizedBox(height: 12),
        EditText(
          controller: widget.control.phoneControl,
          error: widget.control.error.value,
          hint: "Phone",
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          textInputAction: TextInputAction.go,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        Button(
          onClick: widget.control.onLoginClick,
          loading: widget.control.isLoading.value,
          text: "Login/Signup",
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _mailLogin() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 26),
        Text(
          "Enter your mail for Login/Signup",
          style: FontStyles.s16Primary7,
        ),
        const SizedBox(height: 12),
        Obx(() {
          return EditText(
            controller: widget.control.mailControl,
            error: widget.control.error.value,
            hint: "EMail",
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.go,
          );
        }),
        const SizedBox(height: 16),
        Obx(() {
          return Button(
            onClick: widget.control.onLoginClick,
            loading: widget.control.isLoading.value,
            text: "Login/Signup",
          );
        }),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _verifyOTP() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [

        const SizedBox(height: 26),
        Text("Verify OTP", style: FontStyles.s16Primary7),
        const SizedBox(height: 2),
        Text("OTP sent to ${widget.control.tokenUser.value}",
            style: FontStyles.s14Primary705),
        const SizedBox(height: 14),
        Obx(() {
          return EditText(
            controller: widget.control.otpControl,
            hint: "OTP",
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.go,
            isPassword: true,
            error: widget.control.error.value,
            textAlign: TextAlign.center,
            maxLength: 6,
          );
        }),
        const SizedBox(height: 16),
        Obx(() {
          return Button(
            onClick: widget.control.onVerifyClick,
            loading: widget.control.isLoading.value,
            text: "Verify",
          );
        }),
      ],
    );
  }

}
