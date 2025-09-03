import 'package:error_fit/core/app_bars/main_app_bar.dart';
import 'package:error_fit/core/resources/center_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/styles/app_colors.dart';
import '../../../config/styles/font_styles.dart';
import '../../../core/buttons/button.dart';
import '../../../core/widgets/loading_view.dart';
import '../models/cart_model.dart';
import '../widgets/cart_tile.dart';
import 'cart_controller.dart';

class CartWebView extends StatefulWidget {
  final CartController control;

  const CartWebView({super.key, required this.control});

  @override
  State<CartWebView> createState() => _CartWebViewState();
}

class _CartWebViewState extends State<CartWebView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MainAppBar(),
        Expanded(child: Obx(() {
          List<CartModel> list = widget.control.cartList.value;
          return LoadingView(
            controller: widget.control.loadingControl,
            child: SingleChildScrollView(
              child: CenterTab(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 10,),
                    ...List.generate(list.length, (index) =>
                        CartTile(model: list[index], onClick: widget.control
                            .onItemClick, onChangeListener: widget.control
                            .onItemChangeListener,
                         onRemoveClick: widget.control.onRemoveClick,
                        ),),
                    const SizedBox(height: 36,),
                    _checkout(),
                    const SizedBox(height: 16,),
                  ],
                ),
              ),
            ),
          );
        }))
      ],
    );
  }

  Widget _checkout() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Obx(() {
        final checkout = widget.control.checkoutCalculation.value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _checkoutTile("Items", checkout['totalItems'] ?? "0"),
            const SizedBox(height: 8,),
            _checkoutTile("Sub-total", checkout['totalPrice'] ?? "0"),
            // const SizedBox(height: 8,),
            // _checkoutTile("GST(5%)", checkout['gst']??"0"),
            const SizedBox(height: 8,),
            _checkoutTile("Shipping Charge", checkout['shipping'] ?? "0"),
            const SizedBox(height: 12,),
            Divider(color: AppColors.primary70,),
            const SizedBox(height: 12,), Row(
              children: [
                Text("Total", style: FontStyles.s16Primary7,),
                Expanded(child: Text(
                    checkout['overall'] ?? "0", textAlign: TextAlign.end,
                    style: FontStyles.s16Primary7))
              ],
            ),
            const SizedBox(height: 26,),
            Button(onClick: widget.control.onCheckoutClick, text: "Checkout")
          ],
        );
      }),
    );
  }

  Widget _checkoutTile(String title, String value) {
    return Row(
      children: [
        Text(title, style: FontStyles.s16Primary707,),
        Expanded(child: Text(
            value, textAlign: TextAlign.end, style: FontStyles.s16Primary7))
      ],
    );
  }
}
