import 'package:error_fit/config/routes/routers.dart';
import 'package:error_fit/config/services/location_manager.dart';
import 'package:error_fit/config/storage/home_flow_storage.dart';
import 'package:error_fit/core/resources/actions.dart';
import 'package:error_fit/features/search/widgets/brand_model.dart';
import 'package:get/get.dart';

class SearchSectionControl extends GetxController{


  final brandsList = <BrandSearchModel>[].obs;

  @override
  void onInit() {
    _loadBrandList();
    super.onInit();
  }

  void _loadBrandList() {
    brandsList.value = BrandSearchModel.fromJsonList(
        HomeFlowStorage.mobileJson['brands'] ?? []);
  }

  void onSearchClick() {
    productsSearchRoute.navigate;
  }

  void onLocationClick() async {
    final loc = await LocationManager.getCurrentLocation();
    trace("${loc?.longitude ?? 0} - ${loc?.latitude ?? 0}");
  }

}