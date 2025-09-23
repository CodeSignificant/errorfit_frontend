import 'package:error_fit/core/resources/screen_view.dart';
import 'package:error_fit/features/orders/place_order/place_order_controller.dart';
import 'package:error_fit/features/orders/place_order/place_order_mobile_view.dart';
import 'package:flutter/material.dart';

class PlaceOrderPage extends StatefulWidget {
  const PlaceOrderPage({super.key});

  @override
  State<PlaceOrderPage> createState() => _PlaceOrderPageState();
}

class _PlaceOrderPageState extends State<PlaceOrderPage> {

  final control = PlaceOrderController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenView(
        mobile: PlaceOrderMobileView(control: control),
      ),
    );
  }
}
