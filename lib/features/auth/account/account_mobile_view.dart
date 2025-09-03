import 'package:error_fit/config/services/auth.dart';
import 'package:error_fit/core/app_bars/title_appbar.dart';
import 'package:error_fit/core/images/svg_icon.dart';
import 'package:error_fit/core/resources/actions.dart';
import 'package:error_fit/features/auth/account/account_controller.dart';
import 'package:flutter/material.dart';

import '../../../config/styles/app_colors.dart';
import '../../../config/styles/decorations.dart';
import '../../../config/styles/font_styles.dart';
import '../../../core/buttons/anim_button.dart';

class AccountMobileView extends StatefulWidget {
  final AccountController control;

  const AccountMobileView({super.key, required this.control});

  @override
  State<AccountMobileView> createState() => _AccountMobileViewState();
}

class _AccountMobileViewState extends State<AccountMobileView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TitleAppBar(title: "Account"),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
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
                            height: 120,)),
                      // Text("Profile", style: FontStyles.s14Primary704),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text("Name", style: FontStyles.s12Primary704),
                            const SizedBox(height: 4),
                            Text(Auth.name, style: FontStyles.s16Primary7),
                            const SizedBox(height: 16),

                            Text("Mail", style: FontStyles.s12Primary704),
                            const SizedBox(height: 4),
                            Text(Auth.mail, style: FontStyles.s16Primary7),
                            const SizedBox(height: 16),

                            Text("Phone", style: FontStyles.s12Primary704),
                            const SizedBox(height: 4),
                            Text(
                              Auth.phone.isEmpty
                                  ? "Add phone number"
                                  : "${Auth.countryCode} ${Auth.phone}",
                              style: FontStyles.s16Primary7,
                            ),
                            const SizedBox(height: 16),

                            Text("Gender", style: FontStyles.s12Primary704),
                            const SizedBox(height: 4),
                            Text(Auth.gender, style: FontStyles.s16Primary7),
                            const SizedBox(height: 16),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                Row(
                  spacing: 16,
                  children: [
                    Expanded(
                      child: AnimButton(
                        onClick: widget.control.onOrdersClick,
                        child: Container(
                          decoration: Decorations.card,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                          child: Row(
                            spacing: 10,
                            children: [
                              SvgIcon(
                                path: "ic_cart",
                                color: AppColors.primary,
                                size: 20,
                              ),
                              Expanded(
                                child: Text(
                                  "Orders",
                                  style: FontStyles.s14Primary6,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: AnimButton(
                        onClick: widget.control.onWishlistClick,
                        child: Container(
                          decoration: Decorations.card,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                          child: Row(
                            spacing: 10,
                            children: [
                              SvgIcon(
                                path: "ic_unliked",
                                color: AppColors.primary,
                                size: 20,
                              ),
                              Expanded(
                                child: Text(
                                  "Wishlist",
                                  style: FontStyles.s14Primary6,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
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
                          Expanded(child: Text("Default Address", style: FontStyles.s14Primary704)),
                          AnimButton(onClick: widget.control.onChangeAddressClick, child: Text("Add", style: FontStyles.s14Link4,))
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
        SizedBox(height: kBottomBarHeight),
      ],
    );
  }
}
