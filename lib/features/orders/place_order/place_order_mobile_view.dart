import 'package:error_fit/config/extensions/int_extensions.dart';
import 'package:error_fit/config/styles/decorations.dart';
import 'package:error_fit/config/styles/font_styles.dart';
import 'package:error_fit/core/app_bars/title_appbar.dart';
import 'package:error_fit/core/buttons/anim_button.dart';
import 'package:error_fit/core/buttons/button.dart';
import 'package:error_fit/core/buttons/radio_button.dart';
import 'package:error_fit/core/widgets/loading_view.dart';
import 'package:error_fit/core/widgets/shimmer_placeholder.dart';
import 'package:error_fit/features/orders/place_order/place_order_controller.dart';
import 'package:error_fit/features/orders/widgets/place_order_item_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/styles/app_colors.dart';

class PlaceOrderMobileView extends StatefulWidget {
  final PlaceOrderController control;

  const PlaceOrderMobileView({super.key, required this.control});

  @override
  State<PlaceOrderMobileView> createState() => _PlaceOrderMobileViewState();
}

class _PlaceOrderMobileViewState extends State<PlaceOrderMobileView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.control.init();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingView(
      controller: widget.control.paymentLoadingControl,
      loading: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          ),
          const SizedBox(height: 26),
          Text(
            "Please don't press back press until order placed",
            textAlign: TextAlign.center,
            style: FontStyles.s14Primary5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const TitleAppBar(title: "Place Order", tealButton: false),
          Expanded(
            child: LoadingView(
              controller: widget.control.loadingControl,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    _shippingAddress(),
                    const SizedBox(height: 20),
                    _totalMiniCalculation(),
                    const SizedBox(height: 20),
                    _itemsList(),
                    const SizedBox(height: 26),
                    _couponApply(),
                    const SizedBox(height: 26),
                    _totalCalculation(),
                    const SizedBox(height: 26),
                    _paymentMode(),
                    const SizedBox(height: 26),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Button(
                        onClick: widget.control.onConfirmClick,
                        text: "Confirm",
                      ),
                    ),
                    const SizedBox(height: 26),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _shippingAddress() {
    return Obx(() {
      final address = widget.control.selectedAddress.value;
      // Null-safe check
      if (address.id.isEmpty) {
        return ShimmerPlaceholder(
          width: 100,
          height: 140,
          margin: const EdgeInsets.symmetric(horizontal: 12),
        );
      }
      return Container(
        decoration: Decorations.card,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Shipping Address",
                    style: FontStyles.s18Primary5,
                  ),
                ),
                const SizedBox(width: 10),
                AnimButton(
                  onClick: widget.control.onAddressChangeClick,
                  child: Text("Change", style: FontStyles.s14Link4),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(address.name, style: FontStyles.s14Primary704),
            const SizedBox(height: 4),
            Text(
              "${address.address}, ${address.pincode}",
              style: FontStyles.s14Primary704,
            ),
            const SizedBox(height: 4),
            Text(address.mail, style: FontStyles.s14Primary704),
            Text(
              "${address.countryCode } ${address.phone}",
              style: FontStyles.s14Primary704,
            ),
          ],
        ),
      );
    });
  }

  Widget _totalMiniCalculation() {
    return Container(
      decoration: Decorations.card,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Obx(() {
        final calculations = widget.control.orderCalculation.value;
        if (calculations == null) {
          return SizedBox.shrink();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Payable Amount", style: FontStyles.s18Primary5),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(
                      "Total MRP: ", style: FontStyles.s14Primary704),
                ),
                Text((calculations.totalMrpAmount).formatPrice,
                    style: FontStyles.s14Primary5.copyWith(decoration: TextDecoration.lineThrough)),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: Text(
                      "Payable Amount: ", style: FontStyles.s14Primary704),
                ),
                Text((calculations.payableAmount).formatPrice,
                    style: FontStyles.s14Primary5),
              ],
            ),
            const SizedBox(height: 10),
            Button(onClick: widget.control.onConfirmClick, text: "Confirm"),
          ],
        );
      }),
    );
  }

  Widget _itemsList() {
    return Obx(() {
      final calculations = widget.control.orderCalculation.value;
      // Null safety for products list
      if (calculations == null) {
        return SizedBox.shrink();
      }
      final list = calculations.products;
      if (list.isEmpty) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            "No items in your order.",
            textAlign: TextAlign.center,
            style: FontStyles.s14Primary5,
          ),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(
          list.length,
              (index) => PlaceOrderItemTile(model: list[index]),
        ),
      );
    });
  }

  Widget _couponApply() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.primary),
        color: AppColors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.control.couponController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Coupon Code",
              ),
            ),
          ),
          AnimButton(
            onClick: widget.control.onCouponApplyClick,
            child: Text("Apply", style: FontStyles.s14Primary7),
          ),
        ],
      ),
    );
  }

  Widget _totalCalculation() {
    return Container(
      decoration: Decorations.card,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Obx(() {
        final calculations = widget.control.orderCalculation.value;
        if (calculations == null) {
          return SizedBox.shrink();
        }
        int deliveryFee = calculations.deliveryFee ;
        int couponAmount = calculations.couponDiscount ;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Detailed Bill", style: FontStyles.s18Primary5),
            const SizedBox(height: 1),
            Row(
              children: [
                Expanded(
                  child: Text(
                      "Total MRP: ", style: FontStyles.s14Primary704),
                ),
                Text((calculations.totalMrpAmount ).formatPrice,
                    style: FontStyles.s14Primary5.copyWith(decoration: TextDecoration.lineThrough)),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                      "Total Amount: ", style: FontStyles.s14Primary704),
                ),
                Text((calculations.totalAmount ).formatPrice,
                    style: FontStyles.s14Primary5),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text("Delivery Fee: ", style: FontStyles.s14Primary704),
                ),
                Text(
                  (deliveryFee == 0 ? 100 : deliveryFee).formatPrice,
                  style: FontStyles.s14Primary5.copyWith(
                    decoration: deliveryFee == 0 ? TextDecoration.lineThrough : null,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text("Saved discount: ", style: FontStyles.s14Green4),
                ),
                Text("- ${(calculations.totalDiscount).formatPrice}",
                    style: FontStyles.s14Green4),
              ],
            ),
            if (couponAmount != 0)
              Row(
                children: [
                  Expanded(
                    child: Text("Coupon discount: ", style: FontStyles.s14Green4),
                  ),
                  Text("- ${couponAmount.formatPrice}",
                      style: FontStyles.s14Green4),
                ],
              ),
            const SizedBox(height: 1),
            Row(
              children: [
                Expanded(
                  child: Text(
                      "Payable Amount: ", style: FontStyles.s16Primary7),
                ),
                Text((calculations.payableAmount ).formatPrice,
                    style: FontStyles.s16Primary7),
              ],
            ),
          ],
        );
      }),
    );
  }

  Widget _paymentMode() {
    return Container(
      decoration: Decorations.card,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Obx(() {
        final selectedPaymentMode = widget.control.selectedPaymentMode.value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Payment Mode", style: FontStyles.s18Primary5),
            const SizedBox(height: 1),
            Row(
              children: [
                RadioButton(
                  isActive: selectedPaymentMode == "ONLINE",
                  onClick: (isActive) =>
                      widget.control.onPaymentModeClick(mode: "ONLINE"),
                  size: 24,
                ),
                const SizedBox(width: 8),
                const Expanded(child: Text("Online")),
              ],
            ),
            Row(
              children: [
                RadioButton(
                  isActive: selectedPaymentMode == "POD",
                  onClick: (isActive) =>
                      widget.control.onPaymentModeClick(mode: "POD"),
                  size: 24,
                ),
                const SizedBox(width: 8),
                const Expanded(child: Text("Pay on Delivery")),
              ],
            ),
          ],
        );
      }),
    );
  }
}
