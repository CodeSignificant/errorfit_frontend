import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

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
  final Widget Function(String error)? errorBuilder;

  const LoadingView({
    super.key,
    required this.controller,
    required this.child,
    this.errorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(
          child: Lottie.asset(
              "assets/anim/anim_loading.json"),
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
