import 'package:error_fit/config/enums/bottom_nav_types.dart';
import 'package:error_fit/config/routes/routers.dart';
import 'package:error_fit/config/services/auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  final activeTab = BottomNavTypes.home.obs;

  init({String? tab}) async {
    _setTab(tab: tab);
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
}