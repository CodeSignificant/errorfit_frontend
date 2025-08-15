import 'package:error_fit/config/services/auth.dart';
import 'package:error_fit/config/styles/app_colors.dart';
import 'package:error_fit/config/styles/decorations.dart';
import 'package:error_fit/config/styles/font_styles.dart';
import 'package:error_fit/core/buttons/anim_button.dart';
import 'package:error_fit/core/images/svg_icon.dart';
import 'package:error_fit/core/resources/actions.dart';
import 'package:error_fit/features/auth/profile_section/profile_section_control.dart';
import 'package:flutter/material.dart';

class ProfileSection extends StatefulWidget {
  const ProfileSection({super.key});

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  final control = ProfileSectionControl();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: kStatusBarHeight,),
          Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - kToolbarHeight,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 14,
              children: [
                const SizedBox(height: 14),
                Container(
                  decoration: Decorations.card,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 16,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  Auth.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: FontStyles.s20Black6,
                                ),
                                Text(
                                  Auth.mail,
                                  style: FontStyles.s14Primary705,
                                ),
                                Text(
                                  Auth.phone,
                                  style: FontStyles.s14Primary705,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _profileItem(
                  title: "Account",
                  icon: "ic_profile",
                  onClick: control.onAccountClick,
                ),
                _profileItem(
                  title: "Orders",
                  icon: "ic_cart",
                  onClick: control.onAccountClick,
                ),
                _profileItem(
                  title: "WishList",
                  icon: "ic_unliked",
                  onClick: control.onAccountClick,
                ),
                _profileItem(
                  title: "Address",
                  icon: "ic_location",
                  onClick: control.onAccountClick,
                ),
                _profileItem(
                  title: "Notifications",
                  icon: "ic_notification",
                  onClick: control.onAccountClick,
                ),
                _profileItem(
                  title: "Support",
                  icon: "ic_support",
                  onClick: control.onAccountClick,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 8),
                    Text("Terms and Conditions", textAlign: TextAlign.center,
                      style: FontStyles.s14Primary705,),
                    const SizedBox(height: 4),
                    Text("Privacy Policy", textAlign: TextAlign.center,
                      style: FontStyles.s14Primary705,),
                    const SizedBox(height: 4),
                    Text("Version 1.0.0", textAlign: TextAlign.center,
                      style: FontStyles.s14Primary705,),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          AnimButton(
            onClick: control.onLogoutClick,
            child: Container(
              decoration: Decorations.card,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "Logout",
                textAlign: TextAlign.center,
                style: FontStyles.s12Error4,
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
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
        margin: const EdgeInsets.symmetric(horizontal: 12),
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
