import 'package:error_fit/config/extensions/double_extensions.dart';
import 'package:error_fit/core/resources/actions.dart';
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
    await delay(milliSeconds: 1000);
    cartList.addAll(List.generate(10, (index) => CartModel.initial()));
    _calculateCheckout();
    loadingControl.setLoading(false);
  }

  onItemClick(CartModel model) {}

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
    gst = (totalPrice * 0.05);
    shipping = totalPrice >= 499 ? 0 : 100;
    overall += (gst + shipping);

    checkoutCalculation.value = {
      'totalItems': "$totalItems",
      'totalPrice': totalPrice.formatPrice,
      'overall': overall.formatPrice,
      'gst': gst.formatPrice,
      'shipping': shipping > 0 ? "$shipping" : "FREE",
    };
  }
}