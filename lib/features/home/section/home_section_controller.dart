import 'package:error_fit/config/routes/routers.dart';
import 'package:error_fit/features/products/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../config/storage/home_flow_storage.dart';
import '../../../core/widgets/my_carousel.dart';
import '../models/category_model.dart';
import '../models/home_flow_model.dart';

class HomeSectionController extends GetxController{

  final carouselControl = MyCarouselController();
  final scrollControl = ScrollController();
  final showAppbarBackground = false.obs;

  final homeFlowList = <dynamic>[].obs;

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

    carouselControl.list.value = MyCarouselModel.fromJsonList(
        HomeFlowStorage.mobileJson['carousel'] ?? []);

    homeFlowList.value = HomeFlowStorage.mobileJson['flow'] ?? [];

    super.onInit();
  }


  // void _loadHomeFlow() {
  //   final list = List<dynamic>.from(HomeFlowStorage.mobileJson['flow']??[]);
  //   List<HomeFlowModel> flow = [];
  //   for(var item in list){
  //     if(item['type'] == "categories"){
  //       flow.add(CategoryFlowModel.fromJsonList(item['data']));
  //     }
  //   }
  // }

  void onCategoryClick(CategoryFlowModel model) {
    productsSearchRoute.queryParam("category", model.title).navigate;
  }

  onProductClick(ProductModel model) {
    productDetailsRoute.param(model.id).navigate;
  }

  onProductLikeClick(ProductModel model) {}

  void onCarouselItemClick(MyCarouselModel item) {
    navigate(item.route);
  }

}