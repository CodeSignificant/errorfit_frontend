import 'package:error_fit/features/cart/section/cart_section_control.dart';
import 'package:flutter/material.dart';

class CartSection extends StatefulWidget {
  const CartSection({super.key});

  @override
  State<CartSection> createState() => _CartSectionState();
}

class _CartSectionState extends State<CartSection> {

  final control = CartSectionControl();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
