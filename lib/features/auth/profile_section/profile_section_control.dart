import 'package:error_fit/config/routes/routers.dart';
import 'package:error_fit/config/services/auth.dart';
import 'package:error_fit/core/widgets/confirm_dialog.dart';
import 'package:get/get.dart';

class ProfileSectionControl extends GetxController {
  void onAccountClick() {
    accountRoute.navigate;
  }

  void onLogoutClick() {
    Get.dialog(ConfirmDialog(title: "Confirm Logout",
      description: "Are you sure to logout in this device",
      onConfirmClick: () {
        Auth.clearAuth();
        landingRoute.sweepNavigate;
      },));
  }

  void onWishlistClick() {
    wishlistRoute.navigate;
  }

  void onAddressClick() {
    addressRoute.navigate;
  }

  void onNotificationsClick() {
    notificationsRoute.navigate;
  }

  void onSupportClick() {
    supportRoute.navigate;
  }

  void onOrdersClick() {
    ordersRoute.navigate;
  }
}
