import 'package:error_fit/core/app_bars/title_appbar.dart';
import 'package:error_fit/core/buttons/button.dart';
import 'package:error_fit/core/resources/actions.dart';
import 'package:error_fit/core/widgets/loading_view.dart';
import 'package:error_fit/features/address/main/address_controller.dart';
import 'package:error_fit/features/address/widgets/address_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressMobileView extends StatefulWidget {
  final AddressController control;

  const AddressMobileView({super.key, required this.control});

  @override
  State<AddressMobileView> createState() => _AddressMobileViewState();
}

class _AddressMobileViewState extends State<AddressMobileView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TitleAppBar(title: "Address"),
        Expanded(
          child: LoadingView(
            controller: widget.control.loadingControl,
            child: Obx(() {
              final list = widget.control.addressList.value;
              return MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      bottom: 8.0,
                    ),
                    child: AddressTile(
                      model: list[index],
                      onCheckboxClick: widget.control.onCheckboxClick,
                      onDeleteClick: widget.control.onDeleteClick,
                      onEditClick: widget.control.onEditClick,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Button(
            onClick: widget.control.addNewAddressClick,
            text: "Add new Address",
          ),
        ),
        SizedBox(height: kBottomBarHeight),
      ],
    );
  }
}
