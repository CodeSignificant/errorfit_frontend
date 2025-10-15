import 'package:error_fit/core/resources/screen_view.dart';
import 'package:error_fit/features/orders/details/order_details_controller.dart';
import 'package:error_fit/features/orders/details/order_details_mobile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailsPage extends StatefulWidget {
  final String id;

  const OrderDetailsPage({super.key, required this.id});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  final controller = Get.put(OrderDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ScreenView(mobile: OrderDetailsMobile()));
  }
}
