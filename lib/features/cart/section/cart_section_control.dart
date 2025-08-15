import 'package:error_fit/config/extensions/double_extensions.dart';
import 'package:error_fit/config/routes/routers.dart';
import 'package:error_fit/core/app_bars/toast.dart';
import 'package:error_fit/core/network/repo/users/cart_repo.dart';
import 'package:error_fit/core/resources/data_response.dart';
import 'package:error_fit/core/widgets/loading_view.dart';
import 'package:error_fit/features/cart/models/cart_model.dart';
import 'package:get/get.dart';

class CartSectionControl extends GetxController{
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
    productDetailsRoute.param(model.id).navigate;
  }

  onItemChangeListener(CartModel model) {
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
}