import 'package:error_fit/core/resources/screen_view.dart';
import 'package:error_fit/features/orders/main/orders_controller.dart';
import 'package:error_fit/features/orders/main/orders_mobile_view.dart';
import 'package:error_fit/features/orders/main/orders_tab_view.dart';
import 'package:error_fit/features/orders/main/orders_web_view.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final control = OrdersController();

  @override
  void initState() {
    control.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenView(
        mobile: OrdersMobileView(control: control),
        tab: OrdersTabView(control: control),
        web: OrdersWebView(control: control),
      ),
    );
  }
}
