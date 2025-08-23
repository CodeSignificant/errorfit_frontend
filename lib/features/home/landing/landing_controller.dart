import 'package:error_fit/config/enums/login_types.dart';
import 'package:error_fit/config/routes/routers.dart';
import 'package:error_fit/config/storage/home_flow_storage.dart';
import 'package:error_fit/core/network/repo/users/users_repo.dart';
import 'package:error_fit/core/resources/actions.dart';
import 'package:error_fit/core/resources/data_response.dart';
import 'package:error_fit/core/widgets/my_carousel.dart';
import 'package:error_fit/features/home/widgets/mail_login_sheet.dart';
import 'package:error_fit/features/home/widgets/phone_login_sheet.dart';
import 'package:error_fit/features/home/widgets/verify_otp_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_bars/toast.dart';
import '../../../core/network/repo/auth/auth_repo.dart';
import '../../../core/resources/validations.dart';



class LandingController extends GetxController{
  final carouselControl = MyCarouselController();

  // final String androidClientId = '764684738213-9a4pbqcrcmkbvkjvikm5sdu41ol04gpv.apps.googleusercontent.com';
  // final String iosClientId = 'YOUR_IOS_CLIENT_ID.apps.googleusercontent.com';
  // final String webClientId = '764684738213-r22a3vg3olrpk430kufaml0jr84huetg.apps.googleusercontent.com';
  final mailControl = TextEditingController();
  final phoneControl = TextEditingController();
  final otpControl = TextEditingController();
  final isLoading = false.obs;
  final error = "".obs;
  final token = "".obs;
  final tokenUser = "".obs;
  final activeLoginType = LoginTypes.mail.obs;
  final landingWebImage = <String>[].obs;

  void init() async {
    carouselControl.list.value =
    List<dynamic>.from(HomeFlowStorage.mobileJson['landing'] ?? []);
    landingWebImage.value =
    List<String>.from(HomeFlowStorage.webJson['landing'] ?? []);
    // trace(await getUniqueDeviceName());
    // trace(await getAppVersion());
  }


  onLoginTypeSelect(LoginTypes type) {
    // if (type == LoginTypes.google) {
    //   _googleLoginClick();
    //   return;
    // }
    // if (type == LoginTypes.facebook) {
    //   homeRoute.replace;
    //   return;
    // }
    // if (type == LoginTypes.apple) {
    //   homeRoute.replace;
    //   return;
    // }
    if (type == LoginTypes.mail) {
      _mailLoginSheet();
      return;
    }
    if (type == LoginTypes.phone) {
      _phoneLoginSheet();
      return;
    }
  }

  _googleLoginClick() async {
    
  }

  void _mailLoginSheet() async {
    Get.bottomSheet(MailLoginSheet(onComplete: _onMailOTPSentCompleted));
    // showBottomSheet(context: context, builder: (context) => MailLoginSheet(),);
  }

  _onMailOTPSentCompleted(DataResponse response, String mail) async {
    if (response is DataSuccess) {
      closeDialog();
      await delay();
      Get.bottomSheet(VerifyOTPSheet(
        title: "OTP sent successfully to your mail",
        hint: mail,
        token: response.data,
        onComplete: (response) async {
          if (response is DataSuccess) {
            await UsersRepo.info();
            homeRoute.replace;
          }
          if (response is DataFailed) {
            Toast.failed(title: "Unable to Login", message: response.error);
          }
        },));
    }
  }

  _onPhoneOTPSentCompleted(DataResponse response, String phone) async {
    if (response is DataSuccess) {
      closeDialog();
      await delay();
      Get.bottomSheet(VerifyOTPSheet(
        title: "OTP sent successfully to your mail",
        hint: "+91 $phone",
        token: response.data,
        onComplete: (response) async {
          if (response is DataSuccess) {
            await UsersRepo.info();
            homeRoute.replace;
          }
          if (response is DataFailed) {
            Toast.failed(title: "Unable to Login", message: response.error);
          }
        },));
    }
  }

  void _phoneLoginSheet() async {
    Get.bottomSheet(PhoneLoginSheet(onComplete: _onPhoneOTPSentCompleted));
  }


  void onGuestClick() {
    homeRoute.navigate;
  }

  void onLoginClick() async {
    if (activeLoginType.value == LoginTypes.mail) {
      return _mailLogin();
    }
    if (activeLoginType.value == LoginTypes.phone) {
      return _phoneLogin();
    }

  }

  void _mailLogin() async {
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
    if (result is DataSuccess) {
      Toast.success(
        title: "OTP sent successfully",
        message: "check your mail for OTP",
      );
      tokenUser.value = mailControl.text.trim();
      token.value = result.data!;
      return;
    }
    if (result is DataFailed) {
      Toast.failed(title: "OTP sent failed", message: result.error);
      return;
    }
  }

  void _phoneLogin() async {
    error.value = "";
    if (!Validations.isValidIndianMobileNumber(phoneControl.text)) {
      error.value = "Please enter a valid phone";
      return;
    }
    isLoading.value = true;
    final result = await AuthRepo.phoneOTPLogin(
      phone: phoneControl.text.trim().toLowerCase(),
    );
    if (result is DataSuccess) {
      tokenUser.value = "+91 ${phoneControl.text.trim()}";
      token.value = result.data!;
      isLoading.value = false;
      Toast.success(
        title: "OTP sent successfully",
        message: "check your phone for OTP",
      );
      return;
    }
    isLoading.value = false;
    if (result is DataFailed) {
      Toast.failed(title: "OTP sent failed", message: result.error);
      return;
    }
  }

  void onVerifyClick() async {
    error.value = "";
    if (otpControl.text
        .trim()
        .length != 6) {
      error.value = "Please enter a full otp";
      return;
    }
    isLoading.value = true;
    final result = await AuthRepo.verifyOTP(
      otp: otpControl.text.trim(),
      token: token.value,
    );
    if (result is DataSuccess) {
      await UsersRepo.info();
      isLoading.value = false;
      Toast.success(
        title: "Login successfully",
        message: "welcome to the ErrorFit",
      );
      homeRoute.replace;
      return;
    }
    isLoading.value = false;
    if (result is DataFailed) {
      error.value = result.error;
      Toast.failed(title: "Login failed", message: result.error);
      return;
    }
  }

  onLoginTypeClick(LoginTypes type) {
    token.value = "";
    activeLoginType.value = type;
  }

}