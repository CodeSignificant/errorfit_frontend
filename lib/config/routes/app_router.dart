import 'package:error_fit/features/home/landing/landing_page.dart';
import 'package:error_fit/features/home/main/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/auth.dart';
import 'routers.dart';

class AppRouter {
  static List<GetPage> pages = [
    // ------------------------------------------------------------------------ LAUNCH
    GetPage(
      name: "/",
      page: () => const LandingPage(),
      middlewares: [PretendAuthMiddleware()],
    ),

    GetPage(name: homeRoute.route, page: () => const HomePage()),

    //kIsWeb ? const HomePage() :
    // GetPage(name: homeRoute
    //     .route,
    //     page: () =>
    //         HomePage(
    //           navIndex: int.tryParse(Get.parameters['index'] ?? "0") ?? 0,)),
    // GetPage(name: landingRoute.route, page: () => const LandingPage()),
  ];
}

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (!Auth.isLogin) Auth.setPersistenceRoute(route ?? "/");
    return Auth.isLogin ? null : RouteSettings(name: landingRoute.route);
  }
}

class PretendAuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return Auth.isLogin ? RouteSettings(name: homeRoute.route) : null;
  }
}
