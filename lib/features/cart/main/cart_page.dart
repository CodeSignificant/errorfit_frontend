import 'package:error_fit/features/cart/main/cart_controller.dart';
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
    return const Scaffold();
  }
}
