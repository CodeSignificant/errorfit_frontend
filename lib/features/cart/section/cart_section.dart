import 'package:error_fit/config/styles/app_colors.dart';
import 'package:error_fit/config/styles/font_styles.dart';
import 'package:error_fit/core/app_bars/main_app_bar.dart';
import 'package:error_fit/core/buttons/button.dart';
import 'package:error_fit/core/resources/actions.dart';
import 'package:error_fit/core/widgets/loading_view.dart';
import 'package:error_fit/features/cart/models/cart_model.dart';
import 'package:error_fit/features/cart/section/cart_section_control.dart';
import 'package:error_fit/features/cart/widgets/cart_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../main.dart';

class CartSection extends StatefulWidget {
  const CartSection({super.key});

  @override
  State<CartSection> createState() => _CartSectionState();
}

class _CartSectionState extends State<CartSection>
    with RouteAware, WidgetsBindingObserver {

  final control = CartSectionControl();

  @override
  void initState() {
    control.onInit();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    super.didPopNext();
    control.onResume();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MainAppBar(),
        Expanded(child: Obx(() {
          List<CartModel> list = control.cartList.value;
          return LoadingView(
            controller: control.loadingControl,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8,),
                  ...List.generate(list.length, (index) =>
                      CartTile(model: list[index], onClick: control
                          .onItemClick, onChangeListener: control
                          .onItemChangeListener, onRemoveClick: control.onRemoveClick,),),
                  const SizedBox(height: 36,),
                  _checkout(),
                  const SizedBox(height: 16,),
                ],
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
        final checkout = control.checkoutCalculation.value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _checkoutTile("Items", checkout['totalItems']??"0"),
            const SizedBox(height: 8,),
            _checkoutTile("Sub-total", checkout['totalPrice']??"0"),
            // const SizedBox(height: 8,),
            // _checkoutTile("GST(5%)", checkout['gst']??"0"),
            const SizedBox(height: 8,),
            _checkoutTile("Shipping Charge", checkout['shipping']??"0"),
            const SizedBox(height: 12,),
            Divider(color: AppColors.primary70,),
            const SizedBox(height: 12,), Row(
              children: [
                Text("Total", style: FontStyles.s16Primary7,),
                Expanded(child: Text(
                    checkout['overall']??"0", textAlign: TextAlign.end,
                    style: FontStyles.s16Primary7))
              ],
            ),
            const SizedBox(height: 26,),
            Button(onClick: control.onCheckoutClick, text: "Checkout")
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
