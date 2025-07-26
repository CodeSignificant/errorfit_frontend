import 'package:error_fit/config/routes/routers.dart';
import 'package:error_fit/core/resources/actions.dart';
import 'package:error_fit/core/widgets/loading_view.dart';
import 'package:error_fit/features/products/models/product_model.dart';
import 'package:get/get.dart';

class ProductsSearchControl extends GetxController {
  final loadingControl = LoadingViewController();
  final productsList = <ProductModel>[].obs;

  init(Map<String, String?> params) {
    _loadProducts();
  }

  void _loadProducts() async {
    await delay(milliSeconds: 1000);
    productsList.addAll([
      ProductModel.initial(),
      ProductModel.initial(),
      ProductModel.initial(),
      ProductModel.initial(),
      ProductModel.initial(),
      ProductModel.initial(),
      ProductModel.initial(),
      ProductModel.initial(),
      ProductModel.initial(),
      ProductModel.initial(),
      ProductModel.initial(),
      ProductModel.initial(),
      ProductModel.initial(),
      ProductModel.initial(),
      ProductModel.initial(),
      ProductModel.initial(),
      ProductModel.initial(),
      ProductModel.initial(),
      ProductModel.initial(),
      ProductModel.initial(),
      ProductModel.initial(),
      ProductModel.initial(),
    ]);
    loadingControl.setLoading(false);
  }

  onProductClick(ProductModel model) {
    productDetailsRoute.param(model.id).navigate;
  }

  onProductLikeClick(ProductModel model) {}

  void onBackClick() {
    Get.back();
  }
}
