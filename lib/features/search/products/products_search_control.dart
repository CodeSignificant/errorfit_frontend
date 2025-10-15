import 'package:error_fit/config/routes/routers.dart';
import 'package:error_fit/config/services/auth.dart';
import 'package:error_fit/core/network/repo/products/filter_products_repo.dart';
import 'package:error_fit/core/network/repo/users/wishlist_repo.dart';
import 'package:error_fit/core/resources/actions.dart';
import 'package:error_fit/core/resources/data_response.dart';
import 'package:error_fit/core/resources/pagination.dart';
import 'package:error_fit/core/widgets/loading_view.dart';
import 'package:error_fit/features/products/models/product_model.dart';
import 'package:error_fit/features/search/filter/filter_controller.dart';
import 'package:error_fit/features/search/filter/filter_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProductsSearchControl extends GetxController {
  final searchControl = TextEditingController();
  final searchFocus = FocusNode();
  final loadingControl = LoadingViewController();
  final filterController = FilterController();
  final pagination = Pagination();

  init(Map<String, String?> params) {
    if (params.isEmpty) searchFocus.requestFocus();
    debounceListener(searchControl, () {
      if (searchControl.text.isNotEmpty) {
        _loadProducts(
          search: searchControl.text.trim(),
          filter: filterController.getSelectedFilters(),
        );
      }
    },);
    searchFocus.addListener(() {
      if (searchControl.text.isEmpty) {
        if (!searchFocus.hasFocus) _loadProducts();
      }
    },);
    filterController.applyListener(({required filters}) {
      _loadProducts(search: searchControl.text.trim(), filter: filters,);
    },);
    _loadProducts();
  }

  void _loadProducts({String search = "", Map<String, dynamic>? filter}) async {
    pagination.reset();
    Pagination.listener(
      controller: pagination,
      onInitialLoad: () async {
        loadingControl.setLoading(true);
        final result = await FilterProductsRepo.searchProducts(
            search: search, filters: filter ?? {}, page: 1);
        loadingControl.setLoading(false);
        if (result is DataSuccess) {
          return result.data!;
        }
        return null;
      }, onFetch: (nextPage) async {
      final result = await FilterProductsRepo.searchProducts(
          search: search, filters: filter ?? {}, page: nextPage);
      if (result is DataSuccess) {
        return result.data!;
      }
      return null;
    },);

    return;
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


  void onFilterClick() {
    Get.bottomSheet(
        FilterSheet(controller: filterController), isScrollControlled: true);
  }
}
