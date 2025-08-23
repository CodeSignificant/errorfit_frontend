import 'package:error_fit/config/enums/bottom_nav_types.dart';
import 'package:error_fit/config/routes/routers.dart';
import 'package:error_fit/config/services/auth.dart';
import 'package:error_fit/core/widgets/my_carousel.dart';
import 'package:error_fit/features/home/models/home_flow_model.dart';
import 'package:get/get.dart';

import '../../../config/storage/home_flow_storage.dart';

class HomeController extends GetxController{

  final carouselControl = MyCarouselController();
  final activeTab = BottomNavTypes.home.obs;
  final homeFlowList = <dynamic>[].obs;

  init({String? tab}) async {
    _setTab(tab: tab);
    carouselControl.list.value = MyCarouselModel.fromJsonList(
        HomeFlowStorage.webJson['carousel'] ?? []);

    homeFlowList.value = HomeFlowStorage.webJson['flow'] ?? [];
  }

  onBottomNavSelect(BottomNavTypes type) {
    if (!Auth.isLogin && (type == BottomNavTypes.profile || type == BottomNavTypes.cart)) {
      landingRoute.navigate;
      return;
    }
    activeTab.value = type;
  }

  void _setTab({String? tab}) {
    if (tab == "cart") {
      activeTab.value = BottomNavTypes.cart;
      return;
    }
    if (tab == "profile") {
      activeTab.value = BottomNavTypes.profile;
      return;
    }
    if (tab == "search") {
      activeTab.value = BottomNavTypes.search;
      return;
    }
    activeTab.value = BottomNavTypes.home;
  }

  void onCarouselItemClick(MyCarouselModel item) {
    navigate(item.route);
  }

  void onCategoryClick(CategoryFlowModel model) {
    productsSearchRoute
        .queryParam("category", model.title)
        .navigate;
  }
}