import 'package:error_fit/core/resources/screen_view.dart';
import 'package:error_fit/features/cart/main/cart_controller.dart';
import 'package:error_fit/features/cart/main/cart_web_view.dart';
import 'package:error_fit/features/cart/section/cart_section.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  final control = CartController();

  @override
  void initState() {
    control.init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenView(
        mobile: CartSection(),
        web: CartWebView(control: control),
      ),
    );
  }
}
