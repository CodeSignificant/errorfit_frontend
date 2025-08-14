import 'package:error_fit/config/enums/login_types.dart';
import 'package:error_fit/config/routes/routers.dart';
import 'package:error_fit/config/storage/home_flow_storage.dart';
import 'package:error_fit/core/resources/actions.dart';
import 'package:error_fit/core/resources/data_response.dart';
import 'package:error_fit/core/widgets/my_carousel.dart';
import 'package:error_fit/features/home/widgets/mail_login_sheet.dart';
import 'package:error_fit/features/home/widgets/phone_login_sheet.dart';
import 'package:error_fit/features/home/widgets/verify_otp_sheet.dart';
import 'package:get/get.dart';

import '../../../core/app_bars/toast.dart';



class LandingController extends GetxController{
  final carouselControl = MyCarouselController();

  // final String androidClientId = '764684738213-9a4pbqcrcmkbvkjvikm5sdu41ol04gpv.apps.googleusercontent.com';
  // final String iosClientId = 'YOUR_IOS_CLIENT_ID.apps.googleusercontent.com';
  // final String webClientId = '764684738213-r22a3vg3olrpk430kufaml0jr84huetg.apps.googleusercontent.com';

  void init() async {
    carouselControl.list.value =
    List<dynamic>.from(HomeFlowStorage.mobileJson['landing'] ?? []);
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
      _mailLogin();
      return;
    }
    if (type == LoginTypes.phone) {
      _phoneLogin();
      return;
    }
  }

  _googleLoginClick() async {
    
  }

  void _mailLogin() async {
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
        onComplete: (response) {
          if (response is DataSuccess) {
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
        onComplete: (response) {
          if (response is DataSuccess) {
            homeRoute.replace;
          }
          if (response is DataFailed) {
            Toast.failed(title: "Unable to Login", message: response.error);
          }
        },));
    }
  }

  void _phoneLogin() async {
    Get.bottomSheet(PhoneLoginSheet(onComplete: _onPhoneOTPSentCompleted));
  }


}