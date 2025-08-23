import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'config/enums/flavours.dart';
import 'config/environments/config.dart';
import 'config/routes/app_router.dart';
import 'config/services/final_loaders.dart';
import 'config/services/pre_loaders.dart';
import 'config/styles/app_colors.dart';

void main() async {
  await PreLoaders.init();
  await Config.init(Flavours.dev);

  // await Auth.init();
  // await AppState.init();
  await FinalLoaders.init();

  runApp(
    GetMaterialApp(
      title: Config.appName,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        focusColor: AppColors.secondary,
        scaffoldBackgroundColor: AppColors.scaffoldBg,
        fontFamily: 'Poppins',
      ),
      initialRoute: "/",
      getPages: AppRouter.pages,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.trackpad,
        },
      ),
    ),
  );
}
