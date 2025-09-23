import 'package:error_fit/config/styles/decorations.dart';
import 'package:error_fit/config/styles/font_styles.dart';
import 'package:error_fit/core/app_bars/toast.dart';
import 'package:error_fit/core/buttons/button.dart';
import 'package:error_fit/core/buttons/check_button.dart';
import 'package:error_fit/core/edit_texts/edit_text.dart';
import 'package:error_fit/core/network/repo/users/address_repo.dart';
import 'package:error_fit/core/resources/actions.dart';
import 'package:error_fit/core/resources/data_response.dart';
import 'package:error_fit/core/resources/validations.dart';
import 'package:error_fit/core/widgets/sheet_nob.dart';
import 'package:error_fit/features/address/models/address_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditAddressSheet extends StatefulWidget {
  final AddressModel? model;
  final Function(dynamic data, AddressModel address) onSuccess;

  const EditAddressSheet({super.key, required this.onSuccess, this.model});

  @override
  State<EditAddressSheet> createState() => _EditAddressSheetState();
}

class _EditAddressSheetState extends State<EditAddressSheet> {
  final nameControl = TextEditingController();
  final mailControl = TextEditingController();
  final phoneControl = TextEditingController();
  final addressControl = TextEditingController();
  final pincodeControl = TextEditingController();
  final isPrimary = false.obs;
  final isLoading = false.obs;
  final error = "".obs;
  final nameError = "".obs;
  final mailError = "".obs;
  final phoneError = "".obs;
  final addressError = "".obs;
  final pincodeError = "".obs;

  @override
  void initState() {
    if (widget.model != null) {
      nameControl.text = widget.model!.name;
      mailControl.text = widget.model!.mail;
      phoneControl.text = widget.model!.phone;
      pincodeControl.text = widget.model!.pincode;
      addressControl.text = widget.model!.address;
      isPrimary.value = widget.model!.isSelected.value;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: Decorations.sheet,
        constraints: BoxConstraints(
          maxHeight: MediaQuery
              .of(context)
              .size
              .height * 0.9,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            SheetNob(),
            const SizedBox(height: 16),
            Text("Add New Address", style: FontStyles.s16Primary7),
            const SizedBox(height: 16),
            Flexible(
              child: SingleChildScrollView(
                child: Obx(() {
                  return Column(
                    spacing: 16,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      EditText(
                        controller: nameControl,
                        hint: "Name",
                        error: nameError.value,
                      ),
                      EditText(
                        controller: mailControl,
                        hint: "Mail",
                        error: mailError.value,
                      ),
                      EditText(
                        controller: phoneControl,
                        hint: "Phone",
                        error: phoneError.value,
                      ),
                      EditText(
                        controller: pincodeControl,
                        hint: "PinCode",
                        error: pincodeError.value,
                      ),
                      EditText(
                        controller: addressControl,
                        hint: "House number with landmark",
                        maxLines: 3,
                        radius: 16,
                        error: addressError.value,
                      ),
                      Row(
                        children: [
                          CheckButton(
                            isActive: isPrimary.value,
                            onClick: _onPrimaryCheckClick,
                          ),
                          Expanded(
                            child: Text(
                              "Mark this as default address",
                              style: FontStyles.s14Primary6,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        error.value,
                        textAlign: TextAlign.center,
                        style: FontStyles.s12Error4,
                      ),
                      Button(
                        onClick: _onAddClick,
                        text: widget.model == null
                            ? "Add new address"
                            : "Update address",
                        loading: isLoading.value,
                      ),
                      SizedBox(height: kBottomBarHeight),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onPrimaryCheckClick(bool? value) {
    isPrimary.toggle();
  }

  void _onAddClick() async {
    if (!_validate()) return;
    if (widget.model == null) _createNewAddress();
    if (widget.model != null) _updateNewAddress();
  }

  bool _validate() {
    bool valid = true;
    if (nameControl.text.trim().length < 3 ||
        nameControl.text.trim().length > 40) {
      nameError.value = "Please enter name 3-40 characters";
      if (valid) valid = false;
    } else {
      nameError.value = "";
    }
    if (!Validations.isValidEmail(mailControl.text.trim())) {
      mailError.value = "Please enter a valid mail";
      if (valid) valid = false;
    } else {
      mailError.value = "";
    }
    if (!Validations.isValidIndianMobileNumber(phoneControl.text.trim())) {
      phoneError.value = "Please enter a valid phone";
      if (valid) valid = false;
    } else {
      phoneError.value = "";
    }
    if (pincodeControl.text.trim().length != 6) {
      pincodeError.value = "Please enter a valid pincode";
      if (valid) valid = false;
    } else {
      pincodeError.value = "";
    }
    if (addressControl.text.trim().length < 20 ||
        addressControl.text.trim().length > 100) {
      addressError.value = "Please enter 20-100 characters only";
      if (valid) valid = false;
    } else {
      addressError.value = "";
    }
    return valid;
  }

  void _createNewAddress() async {
    isLoading.value = true;
    error.value = "";
    final result = await AddressRepo.addNew(
      name: nameControl.text.trim(),
      mail: mailControl.text.trim(),
      phone: phoneControl.text.trim(),
      countryCode: "+91",
      pincode: pincodeControl.text.trim(),
      address: addressControl.text.trim(),
        makeDefault: isPrimary.value
    );
    isLoading.value = false;
    if (result is DataFailed) {
      Toast.failed(title: "Address Failed", message: result.error);
      error.value = result.error;
      return;
    }
    if (result is DataSuccess) {
      String newId = result.data!.toString();
      AddressModel newModel = AddressModel(
          id: newId,
          name: nameControl.text.trim(),
          mail: mailControl.text.trim(),
          phone: phoneControl.text.trim(),
          countryCode: "+91",
          pincode: pincodeControl.text.trim(),
          address: addressControl.text.trim(),
          isSelected: isPrimary);
      widget.onSuccess(result.data, newModel);
    }
  }

  void _updateNewAddress() async {
    isLoading.value = true;
    error.value = "";
    final result = await AddressRepo.update(
      id: widget.model!.id,
      name: nameControl.text.trim(),
      mail: mailControl.text.trim(),
      phone: phoneControl.text.trim(),
      countryCode: "+91",
      pincode: pincodeControl.text.trim(),
      address: addressControl.text.trim(),
      isPrimary: isPrimary.value,
    );
    isLoading.value = false;
    if (result is DataFailed) {
      Toast.failed(title: "Address Failed", message: result.error);
      error.value = result.error;
      return;
    }
    widget.onSuccess(result.data, AddressModel(
        id: widget.model?.id ?? "",
        name: nameControl.text.trim(),
        mail: mailControl.text.trim(),
        phone: phoneControl.text.trim(),
        countryCode: "+91",
        pincode: pincodeControl.text.trim(),
        address: addressControl.text.trim(),
        isSelected: isPrimary)
    );
  }
}
