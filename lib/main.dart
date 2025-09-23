import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'config/enums/flavours.dart';
import 'config/environments/config.dart';
import 'config/routes/app_router.dart';
import 'config/services/final_loaders.dart';
import 'config/services/pre_loaders.dart';
import 'config/styles/app_colors.dart';

final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();

void main() async {
  await PreLoaders.init();
  await Config.init(Flavours.pro);
  // await AppState.init();
  // await Auth.init();
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
      debugShowCheckedModeBanner: false,
      getPages: AppRouter.pages,
      navigatorObservers: [routeObserver],
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
