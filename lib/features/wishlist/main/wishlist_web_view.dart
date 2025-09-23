import 'package:error_fit/core/app_bars/main_app_bar.dart';
import 'package:error_fit/features/wishlist/main/wishlist_controller.dart';
import 'package:flutter/material.dart';

class WishlistWebView extends StatefulWidget {
  final WishlistController control;

  const WishlistWebView({super.key, required this.control});

  @override
  State<WishlistWebView> createState() => _WishlistWebViewState();
}

class _WishlistWebViewState extends State<WishlistWebView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MainAppBar(),
        Expanded(child: Column()),
      ],
    );
  }
}
