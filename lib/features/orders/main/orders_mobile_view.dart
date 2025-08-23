import 'package:error_fit/core/app_bars/title_appbar.dart';
import 'package:error_fit/core/widgets/loading_view.dart';
import 'package:error_fit/features/orders/main/orders_controller.dart';
import 'package:error_fit/features/orders/widgets/orders_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersMobileView extends StatefulWidget {
  final OrdersController control;

  const OrdersMobileView({super.key, required this.control});

  @override
  State<OrdersMobileView> createState() => _OrdersMobileViewState();
}

class _OrdersMobileViewState extends State<OrdersMobileView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TitleAppBar(title: "Orders"),
        Expanded(
          child: LoadingView(
            controller: widget.control.loadingControl,
            child: Obx(() {
              final list = widget.control.ordersList.value;
              return MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.builder(
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
                      onClick: widget.control.onOrderClick,
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
