import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/styles/app_colors.dart';
import '../../config/styles/break_points.dart';
import '../buttons/svg_icon_button.dart';
import '../images/svg_icon.dart';

class Toast {
  static void success({required String title, required String message}) {
    _show(
      title: title,
      message: message,
        backgroundColor: AppColors.white,
      borderColor: AppColors.green,
      iconPath: "ic_success",
        iconColor: AppColors.green
    );
  }

  static void info({required String title, required String message}) {
    _show(
      title: title,
      message: message,
        backgroundColor: AppColors.white,
      borderColor: AppColors.snackYellow,
      iconPath: "ic_info",
        iconColor: AppColors.snackYellow
    );
  }

  static void failed({required String title, required String message}) {
    _show(
      title: title,
      message: message,
        backgroundColor: AppColors.white,
      borderColor: AppColors.error,
      iconPath: "ic_error",
        iconColor: AppColors.error
    );
  }

  static void _show({
    required String title,
    required String message,
    required Color backgroundColor,
    required Color borderColor,
    required String iconPath,
    required Color iconColor
  }) {
    final context = Get.overlayContext;
    if (context == null) return;

    late OverlayEntry overlay;
    overlay = OverlayEntry(
      builder:
          (_) => _ToastWidget(
            overlay: overlay,
            backgroundColor: backgroundColor,
            borderColor: borderColor,
            iconPath: iconPath,
            title: title,
            message: message,
            iconColor: iconColor,
          ),
    );

    Overlay.of(context).insert(overlay);
  }
}

class _ToastWidget extends StatefulWidget {
  final OverlayEntry overlay;
  final Color backgroundColor;
  final Color borderColor;
  final String iconPath;
  final String title;
  final String message;
  final Color iconColor;

  const _ToastWidget({
    required this.overlay,
    required this.backgroundColor,
    required this.borderColor,
    required this.iconPath,
    required this.title,
    required this.message, required this.iconColor,
  });

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget> {
  Offset _offset = const Offset(0, -1);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() => _offset = const Offset(0, 0));
      }
    });
    Future.delayed(const Duration(seconds: 3), () {
      if (widget.overlay.mounted) widget.overlay.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      child: SafeArea(
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: AnimatedSlide(
              offset: _offset,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              child: Container(
                constraints: BoxConstraints(maxWidth: tabScreen),
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: widget.borderColor),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    SvgIcon(path: widget.iconPath, color: widget.iconColor,),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            widget.title,
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.accent,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          // const SizedBox(height: 4,),
                          Text(
                            widget.message,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.accent,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    SvgIconButton(
                      onClick: () => widget.overlay.remove(),
                      path: "ic_close",
                      color: AppColors.primary25,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
