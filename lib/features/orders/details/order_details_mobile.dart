import 'package:error_fit/core/app_bars/title_appbar.dart';
import 'package:error_fit/features/orders/details/order_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailsMobile extends StatefulWidget {
  const OrderDetailsMobile({super.key});

  @override
  State<OrderDetailsMobile> createState() => _OrderDetailsMobileState();
}

class _OrderDetailsMobileState extends State<OrderDetailsMobile> {
  final control = Get.find<OrderDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TitleAppBar(title: "Order Details"),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [


              ],
            ),
          ),
        ),
      ],
    );
  }
}
