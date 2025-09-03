import 'package:error_fit/config/environments/config.dart';
import 'package:error_fit/config/routes/routers.dart';
import 'package:error_fit/config/services/auth.dart';
import 'package:error_fit/core/app_bars/toast.dart';
import 'package:error_fit/core/network/repo/products/filter_products_repo.dart';
import 'package:error_fit/core/network/repo/users/cart_repo.dart';
import 'package:error_fit/core/network/repo/users/wishlist_repo.dart';
import 'package:error_fit/core/resources/data_response.dart';
import 'package:error_fit/core/widgets/loading_view.dart';
import 'package:error_fit/core/widgets/my_carousel.dart';
import 'package:error_fit/features/products/models/product_details_model.dart';
import 'package:error_fit/features/products/models/product_model.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class ProductDetailsControl extends GetxController {
  String id = "";

  final carouselControl = MyCarouselController();
  final loadingControl = LoadingViewController();

  final isProductLiked = false.obs;
  final details = ProductDetailsModel.initial().obs;

  final selectedImage = "".obs;

  final counter = 1.obs;

  init(String id) {
    this.id = id;
    _loadProduct(id);
  }

  void _loadProduct(String id) async {
    final result = await FilterProductsRepo.details(id: id);
    if (result is DataSuccess) {
      details.value = result.data!;
      carouselControl.list.value = details.value.images;
      selectedImage.value = details.value.images.first;
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

  onLikeClick(bool value) async {
    final result = await WishlistRepo.setLike(
        productId: id, like: value);
    if (result is DataFailed) {
      Toast.info(title: "Unable to Like the Product", message: result.error);
      return;
    }
    isProductLiked.value = value;
  }

  void onAddToCartClick() async {
    if(!Auth.isLogin) {
      landingRoute.navigate;
      return;
    }
    await _setCart();
  }

  void onBuyNowClick() async {
    if(!Auth.isLogin) {
      landingRoute.navigate;
      return;
    }
    await _setCart();
    homeRoute
        .queryParam("tab", "cart")
        .navigate;
  }

  Future<void> _setCart() async {
    final result = await CartRepo.setUpdate(
        productId: id, count: counter.value, selected: true);
    if (result is DataSuccess) {
      Toast.success(title: "Added Successfully", message: result.data!);
      return;
    }
    if (result is DataSuccess) {
      Toast.failed(title: "Failed to add cart", message: result.error);
      return;
    }
    loadingControl.setLoading(false);
  }

  onSimilarProductClick(ProductModel model) {
    productDetailsRoute.param(model.id).navigate;
  }

  onProductLikeClick(ProductModel model) async {
    if(!Auth.isLogin) {
      landingRoute.navigate;
      return;
    }
    final result = await WishlistRepo.setLike(
        productId: model.id, like: model.isLiked.value);
    if (result is DataFailed) {
      Toast.info(title: "Unable to Like the Product", message: result.error);
      return;
    }
  }

  onIncrementClick(int value) {
    if (counter.value >= 10) return;
    counter.value = counter.value + 1;
  }

  onDecrementClick(int value) {
    if (counter.value <= 1) return;
    counter.value = counter.value - 1;
  }

  void onShareClick() async {
    final params = ShareParams(
      text: "${Config.webSiteBase}${productDetailsRoute
          .param(id)
          .route}",
    );
    SharePlus.instance.share(params);
  }

  void onVariantClick(Variant variant) {
    productDetailsRoute.param(variant.id).replace;
  }

  void onSizeClick(SizeOption e) {
    productDetailsRoute.param(e.id).replace;
  }

  void onImageSelect(String image) {
    selectedImage.value = image;
  }

  void onBuyNowWebClick() async {
    if(!Auth.isLogin) {
      landingRoute.navigate;
      return;
    }
    await _setCart();
    cartRoute.navigate;
  }
}
