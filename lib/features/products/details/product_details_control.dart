import 'package:error_fit/config/routes/routers.dart';
import 'package:error_fit/core/resources/actions.dart';
import 'package:error_fit/core/widgets/loading_view.dart';
import 'package:error_fit/core/widgets/my_carousel.dart';
import 'package:error_fit/features/products/models/product_model.dart';
import 'package:get/get.dart';

class ProductDetailsControl extends GetxController {
  String id = "";

  final carouselControl = MyCarouselController();
  final loadingControl = LoadingViewController();

  final isProductLiked = false.obs;

  final carouselList = <MyCarouselModel>[].obs;
  final similarProductsList = <ProductModel>[].obs;

  init(String id) {
    this.id = id;
    _loadProduct(id);
  }

  void _loadProduct(String id) async {
    await delay(milliSeconds: 1000);
    carouselList.value = [
      MyCarouselModel.initial(),
      MyCarouselModel.initial(),
      MyCarouselModel.initial(),
    ];
    similarProductsList.value = [
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
    ];
    carouselControl.list.value = carouselList.value;
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
}
