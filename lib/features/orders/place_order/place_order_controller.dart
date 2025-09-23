import 'package:error_fit/core/network/repo/users/address_repo.dart';
import 'package:error_fit/features/address/models/address_model.dart';
import 'package:error_fit/features/address/widgets/edit_address_sheet.dart';
import 'package:error_fit/features/address/widgets/select_address_sheet.dart';
import 'package:get/get.dart';

import '../../../config/routes/routers.dart';
import '../../../config/services/razorpay_manager.dart';
import '../../../core/app_bars/toast.dart';
import '../../../core/network/repo/orders/orders_repo.dart';
import '../../../core/resources/actions.dart';
import '../../../core/resources/data_response.dart';
import '../../../core/widgets/loading_view.dart';
import '../../cart/models/cart_model.dart';

class PlaceOrderController extends GetxController {
  final paymentLoadingControl = LoadingViewController(initialLoading: false);
  final loadingControl = LoadingViewController();
  final addressController = SelectAddressController();
  final selectedAddress = AddressModel.initial().obs;
  final _razorpay = RazorpayManager();
  final cartList = <CartModel>[].obs;

  void init() {
    _loadItems();
    _getDefaultAddress();
  }

  void _loadItems() async {
    await delay(milliSeconds: 1000);
    loadingControl.setLoading(false);
  }

  void _getDefaultAddress() async {
    final result = await AddressRepo.fetchDefault();
    if (result is DataFailed) {
      Toast.failed(title: "Address Failed", message: "Unable to fetch address");
      return;
    }
    if (result is DataSuccess) {
      selectedAddress.value = result.data!;
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
      paymentMode: "ONLINE",
    );
    if (result is DataFailed) {
      paymentLoadingControl.setLoading(false);
      Toast.failed(title: "Order Failed", message: result.error);
      return;
    }
    _razorpay.init(
      onSuccess: (response) async {
        Toast.success(
          title: "Ordered successfully",
          message: "Order Placed Successfully, Thank you",
        );
        paymentLoadingControl.setLoading(false);
        cartList.value = [];
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
    final paymentResult = await _razorpay.openCheckout(
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
          if (model == null) {
            return;
          }
          selectedAddress.value = model;
          await delay();
          closeDialog();
        },
      ),
      isScrollControlled: true,
      isDismissible: true,
    );
  }

  void _showAddressSheet() {
    Get.bottomSheet(
      EditAddressSheet(
        onSuccess: (data, model) {
          selectedAddress.value = model;
        },
      ),
      isScrollControlled: true,
    );
  }
}
