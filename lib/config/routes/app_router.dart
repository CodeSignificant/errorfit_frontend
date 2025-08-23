import 'package:error_fit/config/services/app_state.dart';
import 'package:error_fit/features/address/main/address_page.dart';
import 'package:error_fit/features/auth/account/account_page.dart';
import 'package:error_fit/features/cart/main/cart_page.dart';
import 'package:error_fit/features/home/landing/landing_page.dart';
import 'package:error_fit/features/home/main/home_page.dart';
import 'package:error_fit/features/home/splash/splash_page.dart';
import 'package:error_fit/features/notifications/main/notifications_page.dart';
import 'package:error_fit/features/orders/main/orders_page.dart';
import 'package:error_fit/features/products/details/product_details_page.dart';
import 'package:error_fit/features/search/products/products_search_page.dart';
import 'package:error_fit/features/support/main/support_page.dart';
import 'package:error_fit/features/wishlist/main/wishlist_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/auth.dart';
import 'routers.dart';

class AppRouter {
  static List<GetPage> pages = [
    // ------------------------------------------------------------------------ LAUNCH
    GetPage(
      name: "/",
      page: () => const SplashPage(),
      // middlewares: [PretendAuthMiddleware()],
    ),
    GetPage(
      name: landingRoute.route,
      page: () => const LandingPage(),
      middlewares: [PretendAuthMiddleware()],
    ),

    GetPage(
      name: homeRoute.route,
      page: () => HomePage(tab: Get.parameters['tab']),
    ),

    // ------------------------------------------------------------------------ PRODUCTS
    GetPage(
      name: productDetailsRoute.key("id").route,
      page: () => ProductDetailsPage(id: Get.parameters['id'] ?? "0"),
      // middlewares: [PretendAuthMiddleware()],
    ),

    // ------------------------------------------------------------------------ SEARCH
    GetPage(
      name: productsSearchRoute.route,
      page: () => ProductsSearchPage(queryParams: Get.parameters),
      // middlewares: [PretendAuthMiddleware()],
    ),

    // ------------------------------------------------------------------------ CART
    GetPage(
      name: cartRoute.route,
      page: () => CartPage(),
      // middlewares: [PretendAuthMiddleware()],
    ),

    // ------------------------------------------------------------------------ ORDERS
    GetPage(
      name: ordersRoute.route,
      page: () => OrdersPage(),
      // middlewares: [PretendAuthMiddleware()],
    ),

    // ------------------------------------------------------------------------ PROFILE
    GetPage(
      name: accountRoute.route,
      page: () => EditProfilePage(),
      // middlewares: [PretendAuthMiddleware()],
    ),
    GetPage(
      name: wishlistRoute.route,
      page: () => WishlistPage(),
      // middlewares: [PretendAuthMiddleware()],
    ),
    GetPage(
      name: addressRoute.route,
      page: () => AddressPage(),
      // middlewares: [PretendAuthMiddleware()],
    ),
    GetPage(
      name: notificationsRoute.route,
      page: () => NotificationsPage(),
      // middlewares: [PretendAuthMiddleware()],
    ),
    GetPage(
      name: supportRoute.route,
      page: () => SupportPage(),
      // middlewares: [PretendAuthMiddleware()],
    ),

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
    if (!Auth.isLogin) AppState.setPersistenceRoute(route ?? "/");
    return Auth.isLogin ? null : RouteSettings(name: landingRoute.route);
  }
}

class PretendAuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return Auth.isLogin ? RouteSettings(name: homeRoute.route) : null;
  }
}
