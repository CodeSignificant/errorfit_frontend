import 'package:error_fit/config/styles/app_colors.dart';
import 'package:error_fit/config/styles/font_styles.dart';
import 'package:error_fit/core/buttons/anim_button.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: 300),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/logos/logo_errorfit.png",
                      height: 50,
                      width: 50,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text("ErrorFit", style: FontStyles.s18White4),
                          Text("Never Settle", style: FontStyles.s10White4),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text("+91 8374273120", style: FontStyles.s14White4),
                Text(
                  "Himayath nagar Nagole, Hyderabad",
                  style: FontStyles.s14White4,
                ),
              ],
            ),
          ),
          Container(
            constraints: BoxConstraints(maxWidth: 300),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Policies", style: FontStyles.s18White4),
                const SizedBox(height: 8),
                AnimButton(
                  onClick: _onPrivacyPolicyClick,
                  child: Text("Privacy Policy", style: FontStyles.s12White4),
                ),
                const SizedBox(height: 4),
                Text("Terms & Conditions", style: FontStyles.s12White4),
                const SizedBox(height: 4),
                Text("Return & Replacement", style: FontStyles.s12White4),
              ],
            ),
          ),
          Container(
            constraints: BoxConstraints(maxWidth: 300),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Company", style: FontStyles.s18White4),
                const SizedBox(height: 8),
                Text("AboutUs", style: FontStyles.s12White4),
                const SizedBox(height: 4),
                Text("Support", style: FontStyles.s12White4),
                const SizedBox(height: 4),
                Text("ContactUs", style: FontStyles.s12White4),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onPrivacyPolicyClick() {}
}
