import 'package:error_fit/config/enums/login_types.dart';
import 'package:error_fit/config/styles/app_colors.dart';
import 'package:error_fit/core/buttons/anim_button.dart';
import 'package:error_fit/core/images/svg_icon.dart';
import 'package:flutter/material.dart';

class LoginTypesRow extends StatelessWidget {
  final Function(LoginTypes type) onSelect;

  const LoginTypesRow({super.key, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            LoginTypes.values.length,
            (index) => AnimButton(
              onClick: () => onSelect(LoginTypes.values[index]),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary70,
                      blurRadius: 2,
                      offset: Offset(2, 2),
                      spreadRadius: 2,
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                child: SvgIcon(path: _findIcon(LoginTypes.values[index])),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _findIcon(LoginTypes value) {
    // if (value == LoginTypes.facebook) return "ic_facebook";
    // if (value == LoginTypes.apple) return "ic_apple";
    if (value == LoginTypes.mail) return "ic_mail";
    if (value == LoginTypes.phone) return "ic_phone";
    return "ic_google";
  }
}
