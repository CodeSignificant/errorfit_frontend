import 'package:error_fit/config/routes/routers.dart';
import 'package:error_fit/config/services/location_manager.dart';
import 'package:error_fit/core/resources/actions.dart';
import 'package:get/get.dart';

class SearchSectionControl extends GetxController{

  void onSearchClick() {
    productsSearchRoute.navigate;
  }

  void onLocationClick() async {
    final loc = await LocationManager.getCurrentLocation();
    trace("${loc?.longitude ?? 0} - ${loc?.latitude ?? 0}");
  }
}