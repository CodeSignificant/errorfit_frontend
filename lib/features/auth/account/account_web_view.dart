import 'package:error_fit/core/app_bars/main_app_bar.dart';
import 'package:error_fit/core/resources/center_tab.dart';
import 'package:error_fit/features/auth/account/account_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/services/auth.dart';
import '../../../config/styles/app_colors.dart';
import '../../../config/styles/decorations.dart';
import '../../../config/styles/font_styles.dart';
import '../../../core/buttons/anim_button.dart';
import '../../../core/images/svg_icon.dart';

class AccountWebView extends StatefulWidget {
  final AccountController control;

  const AccountWebView({super.key, required this.control});

  @override
  State<AccountWebView> createState() => _AccountWebViewState();
}

class _AccountWebViewState extends State<AccountWebView> {

  @override
  void initState() {
    widget.control.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MainAppBar(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            child: CenterTab(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    decoration: Decorations.card,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16)),
                            child: SvgIcon(path: 'ill_profile_bg',
                              fit: BoxFit.cover,
                              height: 200,)),
                        // Text("Profile", style: FontStyles.s14Primary704),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text("Name", style: FontStyles.s12Primary704),
                              const SizedBox(height: 4),
                              Text(
                                  Auth.name, style: FontStyles.s16Primary7),
                              const SizedBox(height: 16),

                              Text("Mail", style: FontStyles.s12Primary704),
                              const SizedBox(height: 4),
                              Text(
                                  Auth.mail, style: FontStyles.s16Primary7),
                              const SizedBox(height: 16),

                              Text(
                                  "Phone", style: FontStyles.s12Primary704),
                              const SizedBox(height: 4),
                              Text(
                                Auth.phone.isEmpty
                                    ? "Add phone number"
                                    : "${Auth.countryCode} ${Auth.phone}",
                                style: FontStyles.s16Primary7,
                              ),
                              const SizedBox(height: 16),

                              Text("Gender",
                                  style: FontStyles.s12Primary704),
                              const SizedBox(height: 4),
                              Text(Auth.gender,
                                  style: FontStyles.s16Primary7),
                              const SizedBox(height: 16),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),


                  Container(
                    decoration: Decorations.card,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Expanded(child: Text("Default Address",
                                style: FontStyles.s14Primary704)),
                            AnimButton(
                                onClick: widget.control
                                    .onChangeAddressClick,
                                child: Text(
                                  "Add", style: FontStyles.s14Link4,))
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Thurpu cheruvu center, veeravasaram 534245, andhra pradesh",
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  Column(
                    spacing: 12,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _profileItem(
                        title: "Orders",
                        icon: "ic_cart",
                        onClick: widget.control.onOrdersClick,
                      ),
                      _profileItem(
                        title: "WishList",
                        icon: "ic_unliked",
                        onClick: widget.control.onWishlistClick,
                      ),
                      _profileItem(
                        title: "Address",
                        icon: "ic_location",
                        onClick: widget.control.onAddressClick,
                      ),
                      _profileItem(
                        title: "Notifications",
                        icon: "ic_notification",
                        onClick: widget.control.onNotificationsClick,
                      ),
                      _profileItem(
                        title: "Support",
                        icon: "ic_support",
                        onClick: widget.control.onSupportClick,
                      ),
                    ],
                  ),
                  const SizedBox(height: 26),


                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        "Terms and Conditions",
                        textAlign: TextAlign.center,
                        style: FontStyles.s14Primary705,),
                      const SizedBox(height: 4),
                      Text("Privacy Policy", textAlign: TextAlign.center,
                        style: FontStyles.s14Primary705,),
                      const SizedBox(height: 4),
                      Obx(() {
                        return Text("Version ${widget.control.appVersion
                            .value}", textAlign: TextAlign.center,
                          style: FontStyles.s14Primary705,);
                      }),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // todo delete account later..
                  // AnimButton(
                  //   onClick: widget.control.onDeleteClick,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Text(
                  //       "Delete Account",
                  //       textAlign: TextAlign.center,
                  //       style: FontStyles.s12Error4,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 16),
                  Row(
                    spacing: 16,
                    children: [
                      Expanded(
                        child: AnimButton(
                          onClick: widget.control.onLogoutAllClick,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Logout All",
                              textAlign: TextAlign.center,
                              style: FontStyles.s12Error4,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AnimButton(
                            onClick: widget.control.onLogoutClick,
                            child: Text(
                              "Logout",
                              textAlign: TextAlign.center,
                              style: FontStyles.s12Error4,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _profileItem({
    required String title,
    required String icon,
    required void Function() onClick,
  }) {
    return AnimButton(
      onClick: onClick,
      child: Container(
        decoration: Decorations.card,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        // margin: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          spacing: 10,
          children: [
            SvgIcon(path: icon, color: AppColors.primary, size: 20,),
            Expanded(child: Text(title, style: FontStyles.s14Primary6)),
            SvgIcon(path: "ic_ios_right", color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
