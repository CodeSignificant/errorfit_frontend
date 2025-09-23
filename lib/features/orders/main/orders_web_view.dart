import 'package:error_fit/core/app_bars/main_app_bar.dart';
import 'package:error_fit/core/resources/center_tab.dart';
import 'package:error_fit/features/orders/main/orders_controller.dart';
import 'package:error_fit/features/orders/widgets/orders_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersWebView extends StatefulWidget {
  final OrdersController control;

  const OrdersWebView({super.key, required this.control});

  @override
  State<OrdersWebView> createState() => _OrdersWebViewState();
}

class _OrdersWebViewState extends State<OrdersWebView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MainAppBar(),
        Expanded(child: Obx(() {
          final list = widget.control.ordersList.value;
          return MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) =>
                  CenterTab(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                      child: OrdersTile(model: list[index],
                      onClick: widget.control.onOrderClick)),),
          );
        }))

      ],
    );
  }
}
