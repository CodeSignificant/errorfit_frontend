import 'package:error_fit/config/enums/bottom_nav_types.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  final activeTab = BottomNavTypes.home.obs;

  onBottomNavSelect(BottomNavTypes type) {
    activeTab.value = type;
  }
}