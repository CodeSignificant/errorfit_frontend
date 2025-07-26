import 'package:error_fit/config/routes/routers.dart';
import 'package:error_fit/features/products/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/widgets/my_carousel.dart';
import '../models/category_model.dart';

class HomeSectionController extends GetxController{

  final carouselControl = MyCarouselController();
  final scrollControl = ScrollController();
  final showAppbarBackground = false.obs;

  final recentlyViewedProducts = <ProductModel>[
    ProductModel.initial(),
    ProductModel.initial(),
    ProductModel.initial(),
    ProductModel.initial(),
    ProductModel.initial(),
  ].obs;

  @override
  void onInit() {
    scrollControl.addListener(() {
      showAppbarBackground.value = scrollControl.offset > 360;
    });

    super.onInit();
  }

  void onCategoryClick(CategoryModel model) {
    productsSearchRoute.queryParam("category", model.title).navigate;
  }

  onProductClick(ProductModel model) {
    productDetailsRoute.param(model.id).navigate;
  }

  onProductLikeClick(ProductModel model) {}
}