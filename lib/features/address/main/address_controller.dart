import 'package:error_fit/core/app_bars/toast.dart';
import 'package:error_fit/core/network/repo/users/address_repo.dart';
import 'package:error_fit/core/resources/actions.dart';
import 'package:error_fit/core/resources/data_response.dart';
import 'package:error_fit/core/widgets/confirm_dialog.dart';
import 'package:error_fit/features/address/models/address_model.dart';
import 'package:error_fit/features/address/widgets/edit_address_sheet.dart';
import 'package:get/get.dart';

import '../../../core/widgets/loading_view.dart';

class AddressController extends GetxController {
  final addressList = <AddressModel>[].obs;
  final loadingControl = LoadingViewController();

  @override
  void onInit() {
    _loadAddress();
    super.onInit();
  }

  void _loadAddress() async {
    loadingControl.setLoading(true);
    final result = await AddressRepo.fetch();
    if (result is DataSuccess) {
      addressList.value = result.data!;
      if (addressList.isEmpty) {
        loadingControl.setError("No Address added");
        return;
      }
      loadingControl.setLoading(false);
    }
    if (result is DataFailed) {
      loadingControl.setError(result.error);
      return;
    }
  }

  onCheckboxClick(AddressModel model) async {
    final result = await AddressRepo.update(
      id: model.id,
      name: model.name,
      mail: model.mail,
      phone: model.phone,
      countryCode: model.countryCode,
      pincode: model.pincode,
      address: model.address,
      isPrimary: true,
      lon: model.lon,
      lat: model.lat,
    );
    if (result is DataSuccess) {
      for (var item in addressList) {
        item.isSelected.value = item.id == model.id;
      }
      return;
    }
    if (result is DataFailed) {
      Toast.failed(title: "Unable to change", message: result.error);
      return;
    }
  }

  onDeleteClick(AddressModel model) async {
    Get.dialog(
      ConfirmDialog(
        title: "Delete Address",
        description: "Are you sure to delete the address :${model.name}",
        onConfirmClick: () async {
          final result = await AddressRepo.delete(id: model.id);
          closeDialog();
          if (result is DataSuccess) {
            addressList.remove(model);
            return;
          }
          if (result is DataFailed) {
            Toast.failed(
              title: "Unable to delete address",
              message: result.error,
            );
            return;
          }
        },
      ),
    );
  }

  onEditClick(AddressModel model) {
    Get.bottomSheet(
      EditAddressSheet(
        model: model,
        onComplete: (response) async {
          if (response is DataSuccess) {
            closeDialog();
            await delay();
            _loadAddress();
          }
        },
      ),
      isScrollControlled: true,
    );
  }

  void addNewAddressClick() {
    Get.bottomSheet(
      EditAddressSheet(
        onComplete: (response) async {
          if (response is DataSuccess) {
            closeDialog();
            await delay();
            _loadAddress();
          }
        },
      ),
      isScrollControlled: true,
    );
  }
}
