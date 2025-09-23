import 'package:error_fit/config/styles/app_colors.dart';
import 'package:error_fit/config/styles/decorations.dart';
import 'package:error_fit/config/styles/font_styles.dart';
import 'package:error_fit/core/app_bars/toast.dart';
import 'package:error_fit/core/buttons/anim_button.dart';
import 'package:error_fit/core/network/repo/users/address_repo.dart';
import 'package:error_fit/core/resources/actions.dart';
import 'package:error_fit/core/resources/data_response.dart';
import 'package:error_fit/core/widgets/sheet_nob.dart';
import 'package:error_fit/core/widgets/shimmer_placeholder.dart';
import 'package:error_fit/features/address/models/address_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectAddressController extends GetxController {
  final addressLoading = true.obs;
  final list = <AddressModel>[].obs;

  void loadAddress() async {
    addressLoading.value = true;
    final result = await AddressRepo.fetch();
    addressLoading.value = false;
    if (result is DataFailed) {
      Toast.failed(title: "Address Failed", message: result.error);
      return;
    }
    if (result is DataSuccess) {
      list.value = result.data!;
    }
  }

  // Future<AddressModel?> onAddressSelected({required AddressModel model}) async {
  //   addressLoading.value = true;
  //   final result = await AddressRepo.updateDefault(id: model.id);
  //   addressLoading.value = false;
  //   if (result is DataFailed) {
  //     Toast.failed(title: "Address Failed", message: result.error);
  //     return null;
  //   }
  //   if (result is DataSuccess) {
  //     return model;
  //   }
  //   return null;
  // }
}

class SelectAddressSheet extends StatefulWidget {
  final SelectAddressController controller;
  final VoidCallback onAddNewClick;
  final Function(AddressModel model)? onCompleted;

  const SelectAddressSheet({
    super.key,
    required this.controller,
    required this.onAddNewClick,
    this.onCompleted,
  });

  @override
  State<SelectAddressSheet> createState() => _SelectAddressSheetState();
}

class _SelectAddressSheetState extends State<SelectAddressSheet> {
  @override
  void initState() {
    widget.controller.loadAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.bottomCenter,
      child: Container(
        decoration: Decorations.sheet,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            SheetNob(),
            const SizedBox(height: 10),
            Text("Select Address", style: FontStyles.s18Primary5),
            const SizedBox(height: 26),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Obx(() {
                final list = widget.controller.list;
                return Row(
                  spacing: 10,
                  children: [
                    if (widget.controller.addressLoading.value)
                      ...List.generate(
                        2,
                        (index) => ShimmerPlaceholder(width: 300, height: 120),
                      ),
                    if (!widget.controller.addressLoading.value)
                      ...List.generate(
                        list.length,
                        (index) => _addressTile(model: list[index]),
                      ),
                    AnimButton(
                      onClick: widget.onAddNewClick,
                      child: Container(
                        decoration: Decorations.card.copyWith(
                          color: AppColors.primary25,
                        ),
                        width: 300,
                        height: 120,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 10,
                          children: [
                            Icon(Icons.add, color: AppColors.primary),
                            Text(
                              "Add New Address",
                              textAlign: TextAlign.center,
                              style: FontStyles.s14Primary5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),

            SizedBox(height: kBottomBarHeight + 16),
          ],
        ),
      ),
    );
  }

  Widget _addressTile({required AddressModel model}) {
    return AnimButton(
      onClick: () => _onAddressSelected(model: model),
      child: Container(
        decoration: Decorations.card,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 6,
          children: [
            Text(model.name, style: FontStyles.s14Primary7),
            Text(
              "${model.countryCode} ${model.phone}",
              style: FontStyles.s14Primary704,
            ),
            Text(
              "${model.address}, ${model.pincode}",
              style: FontStyles.s14Primary704,
            ),
          ],
        ),
      ),
    );
  }

  void _onAddressSelected({required AddressModel model}) async {
    widget.onCompleted?.call(model);
  }
}
