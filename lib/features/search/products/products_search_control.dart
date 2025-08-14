import 'package:error_fit/config/routes/routers.dart';
import 'package:error_fit/config/services/auth.dart';
import 'package:error_fit/core/network/repo/products/filter_products_repo.dart';
import 'package:error_fit/core/resources/data_response.dart';
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
    final result = await FilterProductsRepo.filter();
    if (result is DataSuccess) {
      productsList.addAll(result.data!);
      if (productsList.isEmpty) {
        loadingControl.setError("No products found!");
        return;
      }
      loadingControl.setLoading(false);
      return;
    }
    if (result is DataFailed) {
      loadingControl.setError(result.error);
    }
    loadingControl.setLoading(false);
  }

  onProductClick(ProductModel model) {
    productDetailsRoute.param(model.id).navigate;
  }

  onProductLikeClick(ProductModel model) {
    if (!Auth.isLogin) {
      landingRoute.navigate;
      return;
    }
  }

  void onBackClick() {
    Get.back();
  }
}
