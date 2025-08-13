import 'package:error_fit/config/styles/app_colors.dart';
import 'package:flutter/material.dart';

class SheetNob extends StatelessWidget {
  const SheetNob({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary70,
          borderRadius: BorderRadius.circular(16)
        ),
        width: 42, height: 6,
      ),
    );
  }
}
