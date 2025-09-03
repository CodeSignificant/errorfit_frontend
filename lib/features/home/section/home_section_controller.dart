import 'package:error_fit/config/routes/routers.dart';
import 'package:error_fit/config/services/auth.dart';
import 'package:error_fit/core/network/repo/users/views_repo.dart';
import 'package:error_fit/core/resources/data_response.dart';
import 'package:error_fit/features/products/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../config/storage/home_flow_storage.dart';
import '../../../core/widgets/my_carousel.dart';
import '../models/home_flow_model.dart';

class HomeSectionController extends GetxController{

  final carouselControl = MyCarouselController();
  final scrollControl = ScrollController();
  final showAppbarBackground = false.obs;

  final homeFlowList = <dynamic>[].obs;

  final recentlyViewedProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    scrollControl.addListener(() {
      showAppbarBackground.value = scrollControl.offset > 360;
    });

    carouselControl.list.value = MyCarouselModel.fromJsonList(
        HomeFlowStorage.mobileJson['carousel'] ?? []);

    homeFlowList.value = HomeFlowStorage.mobileJson['flow'] ?? [];

    if(Auth.isLogin){
      _loadRecentlyViewedProducts();
    }

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

  onProductLikeClick(ProductModel model) {
    if(Auth.isLogin){
      landingRoute.navigate;
      return;
    }
  }

  void onCarouselItemClick(MyCarouselModel item) {
    navigate(item.route);
  }

  void _loadRecentlyViewedProducts() async {
    final result = await ViewsRepo.recentlyViewed();
    if(result is DataSuccess){
      recentlyViewedProducts.value = result.data!;
    }
  }

}