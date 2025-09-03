import 'package:error_fit/config/routes/routers.dart';
import 'package:error_fit/core/app_bars/toast.dart';
import 'package:error_fit/core/resources/actions.dart';
import 'package:error_fit/core/resources/data_response.dart';
import 'package:error_fit/core/widgets/confirm_dialog.dart';
import 'package:error_fit/core/widgets/loading_view.dart';
import 'package:error_fit/features/address/widgets/edit_address_sheet.dart';
import 'package:get/get.dart';

import '../../../config/services/auth.dart';
import '../../../core/network/repo/auth/auth_repo.dart';

class AccountController extends GetxController {
  final loadingControl = LoadingViewController();

  void onLogoutClick() {
    Get.dialog(ConfirmDialog(title: "Confirm Logout",
      description: "Are you sure to logout in this device",
      onConfirmClick: () async {
        await AuthRepo.logout();
        Auth.clearAuth();
        landingRoute.sweepNavigate;
      },));
  }

  void onDeleteClick() {}

  void onLogoutAllClick() {
    Get.dialog(ConfirmDialog(title: "Confirm Logout All",
      description: "It will logout all devices you logged in",
      onConfirmClick: () async {
        await AuthRepo.logoutAll();
        Auth.clearAuth();
        landingRoute.sweepNavigate;
      },));
  }

  void onOrdersClick() {
    ordersRoute.navigate;
  }

  void onWishlistClick() {
    wishlistRoute.navigate;
  }

  void onChangeAddressClick() {
    Get.bottomSheet(
      EditAddressSheet(
        onComplete: (response) {
          if (response is DataSuccess) {
            closeDialog();
            Toast.success(
              title: "Address added successfully",
              message: "New address created in your account",
            );
            return;
          }
        },
      ),
      isScrollControlled: true,
    );
  }
}
