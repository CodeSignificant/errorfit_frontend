import 'package:error_fit/config/services/auth.dart';
import 'package:error_fit/core/network/repo/users/address_repo.dart';
import 'package:error_fit/features/address/models/address_model.dart';
import 'package:error_fit/features/address/widgets/edit_address_sheet.dart';
import 'package:error_fit/features/address/widgets/select_address_sheet.dart';
import 'package:error_fit/features/orders/models/order_calculate_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../config/routes/routers.dart';
import '../../../config/services/razorpay_manager.dart';
import '../../../core/app_bars/toast.dart';
import '../../../core/network/repo/orders/orders_repo.dart';
import '../../../core/resources/actions.dart';
import '../../../core/resources/data_response.dart';
import '../../../core/widgets/loading_view.dart';

class PlaceOrderController extends GetxController {
  final paymentLoadingControl = LoadingViewController(initialLoading: false);
  final loadingControl = LoadingViewController();
  final addressController = SelectAddressController();
  final selectedAddress = AddressModel.initial().obs;
  Rxn<OrderCalculateModel> orderCalculation = Rxn(null);
  final couponController = TextEditingController();
  final selectedPaymentMode = "ONLINE".obs;

  void init() async {
    _getDefaultAddress();
  }

  void _getDefaultAddress() async {
    final result = await AddressRepo.fetchDefault();
    if (result is DataFailed) {
      Toast.failed(title: "Address Failed", message: "Unable to fetch address");
      return;
    }
    if (result is DataSuccess) {
      selectedAddress.value = result.data!;
      _calculateOrders();
      return;
    }
  }

  void _calculateOrders() async {
    loadingControl.setLoading(true);
    final result = await OrdersRepo.calculateOrders(
        addressId: selectedAddress.value.id,
        coupon: couponController.text.trim());
    if (result is DataFailed) {
      loadingControl.setError(result.error);
      return;
    }
    if (result is DataSuccess) {
      orderCalculation.value = result.data!;
      loadingControl.setLoading(false);
      return;
    }
  }


  void onConfirmClick() async {
    if (selectedAddress.value.id.isEmpty) {
      Toast.info(
        title: "Address not selected",
        message: "Please select your shipping address",
      );
      return;
    }
    paymentLoadingControl.setLoading(true);

    final result = await OrdersRepo.createOrder(
      addressId: selectedAddress.value.id,
      paymentMode: selectedPaymentMode.value,
      coupon: couponController.text.trim()

    );
    if (result is DataFailed) {
      paymentLoadingControl.setLoading(false);
      Toast.failed(title: "Order Failed", message: result.error);
      return;
    }
    if((result.data?['payment_order_id']??"").toString().isEmpty){
      if(selectedPaymentMode.value == "POD") ordersRoute.replace;
      return;
    }
    final razorpay = RazorpayManager();
    razorpay.init(
      onSuccess: (response) async {
        Toast.success(
          title: "Ordered successfully",
          message: "Order Placed Successfully, Thank you",
        );
        paymentLoadingControl.setLoading(false);
        await delay();
        ordersRoute.replace;
      },
      onCancelled: (response) async {
        Toast.info(
          title: "Payment pending",
          message: "Order placed, waiting for payment",
        );
        paymentLoadingControl.setError("Your payment is under process");
        await delay(milliSeconds: 1000);
        ordersRoute.replace;
      },
      onError: (errors) async {
        Toast.failed(
          title: "Payment failed",
          message: "Complete the payment for order",
        );
        paymentLoadingControl.setError("Your payment is under process");
        await delay(milliSeconds: 1000);
        ordersRoute.replace;
        trace(errors.toString());
      },
    );
    final paymentResult = await razorpay.openCheckout(
      orderId: result.data?['payment_order_id'] ?? "",
    );
    if (paymentResult is DataFailed) {
      paymentLoadingControl.setLoading(false);
      Toast.failed(title: "Payment Failed", message: result.error);
      return;
    }
  }

  void onAddressChangeClick() {
    Get.bottomSheet(
      SelectAddressSheet(
        controller: addressController,
        onAddNewClick: () async {
          closeDialog();
          await delay();
          _showAddressSheet();
        },
        onCompleted: (model) async {
          selectedAddress.value = model;
          await delay();
          closeDialog();
        },
      ),
      // isScrollControlled: true,
      // isDismissible: true,
    );
  }

  void _showAddressSheet() {
    Get.bottomSheet(
      EditAddressSheet(
        onSuccess: (data, model) {
          selectedAddress.value = model;
        },
      ),
      // isDismissible: true,
      // isScrollControlled: true,
    );
  }

  void onCouponApplyClick() async {
    if (couponController.text.isEmpty || couponController.text
        .trim()
        .length != 8) {
      Toast.failed(title: "Invalid Coupon", message: "Enter a valid coupon");
      return;
    }
    // _calculateOrders();
    loadingControl.setLoading(true);
    final result = await OrdersRepo.calculateOrders(
        addressId: selectedAddress.value.id,
        coupon: couponController.text.trim());
    if (result is DataFailed) {
      loadingControl.setError(result.error);
      return;
    }
    if (result is DataSuccess) {
      orderCalculation.value = result.data!;

      loadingControl.setLoading(false);
      return;
    }
  }

  onPaymentModeClick({required String mode}) {
    selectedPaymentMode.value = mode;
  }

}
