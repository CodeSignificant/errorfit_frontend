import 'package:error_fit/config/routes/routers.dart';
import 'package:error_fit/config/styles/app_colors.dart';
import 'package:error_fit/config/styles/decorations.dart';
import 'package:error_fit/config/styles/font_styles.dart';
import 'package:error_fit/core/buttons/anim_button.dart';
import 'package:error_fit/core/buttons/svg_icon_button.dart';
import 'package:error_fit/core/images/svg_icon.dart';
import 'package:error_fit/core/resources/actions.dart';
import 'package:error_fit/features/address/models/address_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/services/auth.dart';
import '../../features/address/widgets/edit_address_sheet.dart';
import '../../features/address/widgets/select_address_sheet.dart';
import '../network/repo/users/address_repo.dart';
import '../resources/data_response.dart';
import '../resources/screen_view.dart';

class MainAppBar extends StatefulWidget {
  final Color background;

  const MainAppBar({super.key, this.background = AppColors.white});

  @override
  State<MainAppBar> createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {

  final selectAddressController = SelectAddressController();
  Rxn<AddressModel> defaultAddress = Rxn(null);

  @override
  void initState() {
    _checkDefaultAddress();
    super.initState();
  }

  void _checkDefaultAddress() async {
    if (!Auth.isLogin) return;
    defaultAddress.value = Auth.defaultAddress;
    if (defaultAddress.value == null) {
      await delay();
      _addNewAddress();
    }
  }

  void _addNewAddress() {
    Get.bottomSheet(
        EditAddressSheet(onSuccess: (data, AddressModel model) async {
          trace("Enter ${model.id}");
          Auth.setDefaultAddress(model.toJson());
          trace("Stored");
          defaultAddress.value = model;
          trace("Updated");
          await delay();
          trace("Hit Closed");
          closeDialog();
        },),
        isDismissible: true,
        isScrollControlled: true);
  }

  void _onAddressClick() async {
    Get.bottomSheet(SelectAddressSheet(
      controller: selectAddressController, onAddNewClick: () async {
      closeDialog();
      await delay();
      _addNewAddress();
    }, onCompleted: (AddressModel model) async {
      final result = await AddressRepo.updateDefault(id: model.id);
      if (result is DataSuccess) {
        Auth.setDefaultAddress(model.toJson());
        defaultAddress.value = model;
      }
      closeDialog();
    },));
  }

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
      color: widget.background,
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: kStatusBarHeight,),
          Row(
            children: [
              const SizedBox(width: 12,),
              Image.asset(
                "assets/logos/img_ef_banner.png", width: 80, height: 36,),
              const Spacer(),
              const SizedBox(width: 16,),
              Obx(() {
                final address = defaultAddress.value;
                if (address == null) return SizedBox();
                return AnimButton(
                  onClick: _onAddressClick,
                  child: Container(
                    decoration: Decorations.card,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    width: 120,
                    child: Row(
                      spacing: 10,
                      children: [
                        SvgIcon(path: "ic_location",
                          size: 16,
                          color: AppColors.primary,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(address.name, maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: FontStyles.s12Black4,),
                              Text(address.pincode, maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: FontStyles.s10Primary704,)
                            ],
                          ),
                        ),
                        Icon(Icons.expand_more, color: AppColors.primary,)
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(width: 10,),
              SvgIconButton(onClick: _onTileIconClick,
                path: "ic_notification",
                color: AppColors.primary,),
              const SizedBox(width: 16,),
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
      color: widget.background,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: kStatusBarHeight,),
          Row(
            children: [
              const SizedBox(width: 12,),
              AnimButton(
                onClick: () => homeRoute.navigate,
                child: Image.asset(
                  "assets/logos/img_ef_banner.png", width: 80, height: 36,),
              ),
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
    accountRoute.navigate;
  }
}
