import 'package:error_fit/features/orders/main/orders_controller.dart';
import 'package:flutter/material.dart';

class OrdersWebView extends StatefulWidget {
  final OrdersController control;
  const OrdersWebView({super.key, required this.control});

  @override
  State<OrdersWebView> createState() => _OrdersWebViewState();
}

class _OrdersWebViewState extends State<OrdersWebView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
