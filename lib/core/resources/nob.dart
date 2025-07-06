import 'package:flutter/material.dart';

import '../../config/styles/app_colors.dart';

class Nob extends StatelessWidget {
  const Nob({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 5,
        width: 48,
        decoration: BoxDecoration(
          color: AppColors.light,
          borderRadius: BorderRadius.circular(26)
        ),
      ),
    );
  }
}
