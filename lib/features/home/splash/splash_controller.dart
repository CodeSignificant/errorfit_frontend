import 'package:error_fit/config/routes/routers.dart';
import 'package:error_fit/config/services/auth.dart';
import 'package:error_fit/config/storage/home_flow_storage.dart';
import 'package:error_fit/core/app_bars/toast.dart';
import 'package:error_fit/core/network/repo/auth/auth_repo.dart';
import 'package:error_fit/core/network/repo/utils/public_repo.dart';
import 'package:error_fit/core/resources/data_response.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    _loadHomeFlow();
    super.onInit();
  }

  void _loadHomeFlow() async {
    final result = await PublicRepo.getHomeFlow();
    if (result is DataSuccess) {
      HomeFlowStorage.setAppInfoJson(result.data?['app_info'] ?? {});
      HomeFlowStorage.setMobileJson(result.data?['mobile'] ?? {});
      HomeFlowStorage.setTabJson(result.data?['tab'] ?? {});
      HomeFlowStorage.setWebJson(result.data?['web'] ?? {});
      if (Auth.isLogin) {
        await AuthRepo.info();
        homeRoute.replace;
      } else {
        landingRoute.replace;
      }
      return;
    }

    Toast.failed(
      title: "App Launch Failed",
      message: "Please update the latest app",
    );
  }
}
