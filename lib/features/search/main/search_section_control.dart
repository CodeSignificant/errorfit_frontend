import 'package:error_fit/config/routes/routers.dart';
import 'package:error_fit/config/services/auth.dart';
import 'package:error_fit/config/storage/home_flow_storage.dart';
import 'package:error_fit/core/network/repo/users/address_repo.dart';
import 'package:error_fit/core/resources/actions.dart';
import 'package:error_fit/core/resources/data_response.dart';
import 'package:error_fit/features/address/widgets/edit_address_sheet.dart';
import 'package:error_fit/features/address/widgets/select_address_sheet.dart';
import 'package:error_fit/features/search/widgets/brand_model.dart';
import 'package:get/get.dart';

import '../../address/models/address_model.dart';

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

}