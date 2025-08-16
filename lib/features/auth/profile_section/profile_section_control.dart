import 'package:error_fit/config/routes/routers.dart';
import 'package:error_fit/config/services/auth.dart';
import 'package:get/get.dart';

class ProfileSectionControl extends GetxController {
  void onAccountClick() {}

  void onLogoutClick() {
    Auth.clearAuth();
    landingRoute.sweepNavigate;
  }

  void onWishlistClick() {
    wishlistRoute.navigate;
  }
}
