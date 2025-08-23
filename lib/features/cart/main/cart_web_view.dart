import 'package:error_fit/core/app_bars/main_app_bar.dart';
import 'package:error_fit/features/cart/main/cart_controller.dart';
import 'package:flutter/material.dart';

class CartWebView extends StatefulWidget {
  final CartController control;

  const CartWebView({super.key, required this.control});

  @override
  State<CartWebView> createState() => _CartWebViewState();
}

class _CartWebViewState extends State<CartWebView> {
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
