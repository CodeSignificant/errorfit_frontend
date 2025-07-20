import 'package:error_fit/config/enums/login_types.dart';
import 'package:error_fit/config/routes/routers.dart';
import 'package:error_fit/core/widgets/my_carousel.dart';
import 'package:get/get.dart';

class LandingController extends GetxController{
  final carouselControl = MyCarouselController();

  void init(){

  }

  onLoginTypeSelect(LoginTypes type) {
    if (type == LoginTypes.google) {
      homeRoute.replace;
      return;
    }
    if (type == LoginTypes.facebook) {
      homeRoute.replace;
      return;
    }
    if (type == LoginTypes.apple) {
      homeRoute.replace;
      return;
    }
    if (type == LoginTypes.mail) {
      homeRoute.replace;
      return;
    }
    if (type == LoginTypes.phone) {
      homeRoute.replace;
      return;
    }
  }
}