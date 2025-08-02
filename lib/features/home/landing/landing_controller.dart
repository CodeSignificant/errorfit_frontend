import 'dart:async';
import 'dart:io';

import 'package:error_fit/config/enums/login_types.dart';
import 'package:error_fit/config/routes/routers.dart';
import 'package:error_fit/core/resources/actions.dart';
import 'package:error_fit/core/widgets/my_carousel.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
import 'package:google_sign_in_web/google_sign_in_web.dart' as web_plugin;



class LandingController extends GetxController{
  final carouselControl = MyCarouselController();

  final GoogleSignIn signIn = GoogleSignIn.instance;
  final String androidClientId = '764684738213-9a4pbqcrcmkbvkjvikm5sdu41ol04gpv.apps.googleusercontent.com';
  final String iosClientId = 'YOUR_IOS_CLIENT_ID.apps.googleusercontent.com';
  final String webClientId = '764684738213-r22a3vg3olrpk430kufaml0jr84huetg.apps.googleusercontent.com';

  void init(){
    _setupGoogleSignIn();

  }

  void _setupGoogleSignIn() async {

    final String clientId = kIsWeb
        ? webClientId
        : defaultTargetPlatform == TargetPlatform.android
        ? androidClientId
        : defaultTargetPlatform == TargetPlatform.iOS
        ? iosClientId
        : webClientId; // fallback

    await signIn.initialize(
      clientId: clientId,
      serverClientId: webClientId, // always web client id here
    );

    // Listen for authentication events globally (optional)
    signIn.authenticationEvents.listen((event) {
      // Handle user sign-in/out here, update your app state accordingly
    });

    // Attempt silent sign-in if possible (optional)
    await signIn.attemptLightweightAuthentication();

  }

  onLoginTypeSelect(LoginTypes type) {
    if (type == LoginTypes.google) {
      // homeRoute.replace;
      _googleLoginClick();
      return;
    }
    if (type == LoginTypes.facebook) {
      homeRoute.replace;
      return;
    }
    if (type == LoginTypes.apple) {
      homeRoute.replace;
      return;
    }
    if (type == LoginTypes.mail) {
      homeRoute.replace;
      return;
    }
    if (type == LoginTypes.phone) {
      homeRoute.replace;
      return;
    }
  }

  _googleLoginClick() async {
    if (kIsWeb) {
      // On web, you must use the official rendered Google button:
      return (GoogleSignInPlatform.instance as web_plugin.GoogleSignInPlugin).renderButton();
    }
    if (GoogleSignIn.instance.supportsAuthenticate()){
      try {
        final user = await GoogleSignIn.instance.authenticate();
        trace(user.toString());
      } catch (e) {
        // Handle error
        trace(e.toString());
      }
      return;
    }
    // try {
    //   final user = await signIn.signIn();
    //   // Handle user info
    // } catch (error) {
    //   // Handle error
    // }
    // final GoogleSignInAccount? user = signIn;
    
  }


}