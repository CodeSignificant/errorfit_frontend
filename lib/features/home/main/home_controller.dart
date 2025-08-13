import 'package:error_fit/config/enums/bottom_nav_types.dart';
import 'package:error_fit/config/routes/routers.dart';
import 'package:error_fit/config/services/auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  final activeTab = BottomNavTypes.home.obs;

  onBottomNavSelect(BottomNavTypes type) {
    if (!Auth.isLogin && (type == BottomNavTypes.profile || type == BottomNavTypes.cart)) {
      landingRoute.navigate;
      return;
    }
    activeTab.value = type;
  }
}