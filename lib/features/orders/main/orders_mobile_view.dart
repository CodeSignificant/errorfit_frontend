import 'package:error_fit/core/app_bars/title_appbar.dart';
import 'package:error_fit/core/widgets/loading_view.dart';
import 'package:error_fit/features/orders/main/orders_controller.dart';
import 'package:error_fit/features/orders/models/orders_model.dart';
import 'package:error_fit/features/orders/widgets/orders_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersMobileView extends StatelessWidget {
  final OrdersController control;

  const OrdersMobileView({super.key, required this.control});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TitleAppBar(title: "Orders"),
        Expanded(
          child: LoadingView(
            controller: control.loadingControl,
            child: Obx(() {
              final list = control.paginationControl.items;
              // Show empty state if no items yet
              if (list.isEmpty) {
                return const Center(
                  child: Text("No orders found"),
                );
              }
              return MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.builder(
                  controller: control.paginationControl.scrollController,
                  itemCount: list.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(
                      left: 12,
                      right: 12,
                      top: index == 0 ? 10 : 0,
                      bottom: 10.0,
                    ),
                    child: OrdersTile(
                      model: list[index],
                      onClick: control.onOrderClick,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
