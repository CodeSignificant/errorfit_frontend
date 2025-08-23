import 'package:error_fit/config/routes/routers.dart';
import 'package:error_fit/core/network/repo/products/filter_products_repo.dart';
import 'package:error_fit/core/resources/data_response.dart';
import 'package:error_fit/core/widgets/loading_view.dart';
import 'package:error_fit/core/widgets/my_carousel.dart';
import 'package:error_fit/features/products/models/product_details_model.dart';
import 'package:error_fit/features/products/models/product_model.dart';
import 'package:get/get.dart';

class ProductDetailsControl extends GetxController {
  String id = "";

  final carouselControl = MyCarouselController();
  final loadingControl = LoadingViewController();

  final isProductLiked = false.obs;
  final details = ProductDetailsModel.initial().obs;

  init(String id) {
    this.id = id;
    _loadProduct(id);
  }

  void _loadProduct(String id) async {
    final result = await FilterProductsRepo.details(id: id);
    if (result is DataSuccess) {
      details.value = result.data!;
      carouselControl.list.value = details.value.images;
      isProductLiked.value = details.value.isLiked;
      loadingControl.setLoading(false);
      return;
    }
    if (result is DataSuccess) {
      loadingControl.setError(result.error);
      return;
    }
    loadingControl.setLoading(false);
  }

  onLikeClick(bool value) {
    isProductLiked.value = value;
  }

  void onAddToCartClick() {}

  void onBuyNowClick() {}

  onSimilarProductClick(ProductModel model) {
    productDetailsRoute.param(model.id).navigate;
  }

  onProductLikeClick(ProductModel model) {}

  onIncrementClick(int value) {}

  onDecrementClick(int value) {}

  void onShareClick() {}

  void onVariantClick(Variant variant) {
    productDetailsRoute.param(variant.id).replace;
  }

  void onSizeClick(SizeOption e) {
    productDetailsRoute.param(e.id).replace;
  }
}
