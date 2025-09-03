import 'package:error_fit/config/extensions/double_extensions.dart';
import 'package:error_fit/core/resources/actions.dart';
import 'package:error_fit/core/widgets/confirm_dialog.dart';
import 'package:get/get.dart';

import '../../../config/routes/routers.dart';
import '../../../core/app_bars/toast.dart';
import '../../../core/network/repo/users/cart_repo.dart';
import '../../../core/resources/data_response.dart';
import '../../../core/widgets/loading_view.dart';
import '../models/cart_model.dart';

class CartController extends GetxController {
  final loadingControl = LoadingViewController();

  final cartList = <CartModel>[].obs;

  final checkoutCalculation = <String, String>{}.obs;

  @override
  void onInit() async {
    _loadCart();
    super.onInit();
  }

  void _loadCart() async {
    final result = await CartRepo.fetch();
    if (result is DataSuccess) {
      cartList.addAll(result.data!);
      if (cartList.isEmpty) {
        loadingControl.setError("No Products in the Cart");
        return;
      }
      _calculateCheckout();
      loadingControl.setLoading(false);
    }
    if (result is DataFailed) {
      loadingControl.setError(result.error);
      Toast.failed(title: "Fetch Failed", message: result.error);
      return;
    }
    // cartList.addAll(List.generate(10, (index) => CartModel.initial()));
  }

  onItemClick(CartModel model) {
    productDetailsRoute
        .param(model.productId)
        .navigate;
  }

  onItemChangeListener(CartModel model) {
    _updateCart(model);
    _calculateCheckout();
  }

  void onCheckoutClick() {}

  void _calculateCheckout() {
    int totalItems = 0;
    double totalPrice = 0;
    double overall = 0;
    double gst = 0;
    double shipping = 0;

    for (final item in cartList.value) {
      if (item.isSelect.value) {
        final itemTotal = item.price * item.count.value;
        totalItems += item.count.value;
        totalPrice += itemTotal;
        overall += itemTotal;
      }
    }
    // gst = (totalPrice * 0.05);
    shipping = totalPrice >= 499 ? 0 : 100;
    overall += (0 + shipping);

    checkoutCalculation.value = {
      'totalItems': "$totalItems",
      'totalPrice': totalPrice.formatPrice,
      'overall': overall.formatPrice,
      // 'gst': gst.formatPrice,
      'shipping': shipping > 0 ? "$shipping" : "FREE",
    };
  }

  void _updateCart(CartModel model) async {
    final result = await CartRepo.setUpdate(productId: model.productId,
        count: model.count.value,
        selected: model.isSelect.value);

    if (result is DataFailed) {
      Toast.failed(title: "Cart not updated", message: result.error);
      return;
    }
  }

  onRemoveClick(CartModel model) {
    Get.dialog(ConfirmDialog(
      title: "Remove Item in Cart",
      description: "Do you really want to remove an item: ${model.title}",
      onConfirmClick: () {
        _onDeleteItem(model);
        closeDialog();
      },
    ));
  }

  void _onDeleteItem(CartModel model) async {
    final result = await CartRepo.remove(productId: model.id);
    if (result is DataSuccess) {
      cartList.remove(model);
      if (cartList.isEmpty) {
        loadingControl.setError(
            "Grab product in your cart now.");
      }
      return;
    }
    if (result is DataFailed) {
      Toast.failed(title: "Unable to remove", message: result.error);
      return;
    }
  }
}
