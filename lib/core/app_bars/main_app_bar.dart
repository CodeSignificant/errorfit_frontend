import 'package:error_fit/config/routes/routers.dart';
import 'package:error_fit/config/services/auth.dart';
import 'package:error_fit/config/styles/app_colors.dart';
import 'package:error_fit/core/buttons/svg_icon_button.dart';
import 'package:error_fit/core/resources/actions.dart';
import 'package:flutter/material.dart';

import '../resources/screen_view.dart';

class MainAppBar extends StatelessWidget {
  final Color background;
  const MainAppBar({super.key, this.background = AppColors.white});

  @override
  Widget build(BuildContext context) {
    return ScreenView(
      mobile: _mobileView(),
      web: _webView(),
    );
  }

  Widget _mobileView() {
    return Container(
      // constraints: BoxConstraints(minHeight: 70),
      height: kToolbarHeight + kStatusBarHeight,
      color: background,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: kStatusBarHeight,),
          Row(
            children: [
              const SizedBox(width: 12,),
              Image.asset("assets/logos/img_ef_banner.png", width: 80, height: 36,),
              const Spacer(),
              SvgIconButton(onClick: _onTileIconClick,
                path: "ic_notification",
                color: AppColors.primary,),
              const SizedBox(width: 16,)
            ],
          ),
        ],
      ),
    );
  }

  Widget _webView() {
    return Container(
      // constraints: BoxConstraints(minHeight: 70),
      height: kToolbarHeight + kStatusBarHeight,
      color: background,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: kStatusBarHeight,),
          Row(
            children: [
              const SizedBox(width: 12,),
              Image.asset(
                "assets/logos/img_ef_banner.png", width: 80, height: 36,),
              const Spacer(),
              SvgIconButton(
                onClick: _onSearchClick,
                path: "ic_search",
                color: AppColors.primary,),
              const SizedBox(width: 12,),
              SvgIconButton(
                onClick: _onCartClick,
                path: "ic_cart",
                color: AppColors.primary,),
              const SizedBox(width: 12,),
              SvgIconButton(
                onClick: _onNotificationClick,
                path: "ic_notification",
                color: AppColors.primary,),
              const SizedBox(width: 12,),
              SvgIconButton(
                onClick: _onProfileClick,
                path: "ic_profile",
                color: AppColors.primary,),
              const SizedBox(width: 16,)
            ],
          ),
        ],
      ),
    );
  }

  void _onTileIconClick() {
    notificationsRoute.navigate;
  }

  void _onCartClick() {
    cartRoute.navigate;
  }

  void _onNotificationClick() {
    notificationsRoute.navigate;
  }


  void _onSearchClick() {
    productsSearchRoute.navigate;
  }

  void _onProfileClick() {
    Auth.clearAuth();
    landingRoute.sweepNavigate;
  }
}
