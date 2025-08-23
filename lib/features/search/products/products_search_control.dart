import 'package:error_fit/config/routes/routers.dart';
import 'package:error_fit/config/services/auth.dart';
import 'package:error_fit/core/network/repo/products/filter_products_repo.dart';
import 'package:error_fit/core/network/repo/users/wishlist_repo.dart';
import 'package:error_fit/core/resources/actions.dart';
import 'package:error_fit/core/resources/data_response.dart';
import 'package:error_fit/core/widgets/loading_view.dart';
import 'package:error_fit/features/products/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProductsSearchControl extends GetxController {
  final searchControl = TextEditingController();
  final searchFocus = FocusNode();
  final loadingControl = LoadingViewController();
  final productsList = <ProductModel>[].obs;

  init(Map<String, String?> params) {
    if (params.isEmpty) searchFocus.requestFocus();
    debounceListener(searchControl, () {
      if (searchControl.text.isNotEmpty) {
        _searchProducts(search: searchControl.text.trim());
      } else {
        productsList.value = [];
      }
    },);
    searchFocus.addListener(() {
      if (searchControl.text.isEmpty) {
        if (!searchFocus.hasFocus) _loadProducts();
      }
    },);
    _loadProducts();
  }

  void _loadProducts() async {
    final result = await FilterProductsRepo.filter();
    if (result is DataSuccess) {
      productsList.value = result.data!;
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

  onProductLikeClick(ProductModel model) async {
    if (!Auth.isLogin) {
      landingRoute.navigate;
      return;
    }
    await WishlistRepo.setLike(productId: model.id, like: model.isLiked.value);
  }

  void onBackClick() {
    Get.back();
  }

  void onSearchIconClick() {
    searchFocus.unfocus();
  }

  void _searchProducts({required String search}) async {
    loadingControl.setLoading(true);
    final result = await FilterProductsRepo.search(search: search);
    if (result is DataSuccess) {
      productsList.value = result.data!;
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
}
