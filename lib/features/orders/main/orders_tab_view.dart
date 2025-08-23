import 'package:error_fit/features/orders/main/orders_controller.dart';
import 'package:flutter/material.dart';

class OrdersTabView extends StatefulWidget {
  final OrdersController control;
  const OrdersTabView({super.key, required this.control});

  @override
  State<OrdersTabView> createState() => _OrdersTabViewState();
}

class _OrdersTabViewState extends State<OrdersTabView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
