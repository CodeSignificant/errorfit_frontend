import 'package:error_fit/config/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/styles/font_styles.dart';

class LoadingViewController extends GetxController {
  final isLoading = true.obs;
  final error = "".obs;

  LoadingViewController({bool initialLoading = true}) {
    isLoading.value = initialLoading;
  }

  void setLoading(bool value) {
    isLoading.value = value;
    error.value = "";
  }

  void setError(String value) {
    isLoading.value = false;
    error.value = value;
  }
}


class LoadingView extends StatelessWidget {
  final LoadingViewController controller;
  final Widget child;
  final Widget? loading;
  final Widget Function(String error)? errorBuilder;

  const LoadingView({
    super.key,
    required this.controller,
    required this.child,
    this.errorBuilder, this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return loading??Center(
          child: SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
        );
      }

      if (controller.error.value.isNotEmpty) {
        if (errorBuilder != null) {
          return errorBuilder!(controller.error.value);
        }

        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              controller.error.value,
              textAlign: TextAlign.center,
              style: FontStyles.s14Text4,
            ),
          ),
        );
      }

      return child;
    });
  }
}
