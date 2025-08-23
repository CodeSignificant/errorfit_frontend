import 'package:error_fit/config/styles/decorations.dart';
import 'package:error_fit/config/styles/font_styles.dart';
import 'package:error_fit/core/buttons/check_button.dart';
import 'package:error_fit/core/buttons/svg_icon_button.dart';
import 'package:error_fit/features/address/models/address_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressTile extends StatelessWidget {
  final AddressModel model;
  final Function(AddressModel model) onCheckboxClick;
  final Function(AddressModel model) onDeleteClick;
  final Function(AddressModel model) onEditClick;

  const AddressTile({
    super.key,
    required this.model,
    required this.onCheckboxClick,
    required this.onDeleteClick,
    required this.onEditClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Decorations.card,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Obx(() {
            return CheckButton(
              isActive: model.isSelected.value,
              onClick: (isActive) => onCheckboxClick(model),
            );
          }),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(model.name, style: FontStyles.s16Primary7),
                Text(
                  "${model.countryCode} ${model.phone}",
                  style: FontStyles.s14Primary6,
                ),
                Text(model.address, style: FontStyles.s14Primary705),
                Row(
                  children: [
                    Expanded(
                      child: Text(model.mail, style: FontStyles.s14Primary704),
                    ),
                    Text(model.pincode, style: FontStyles.s14Primary704),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            children: [
              SvgIconButton(
                path: "ic_delete",
                size: 24,
                onClick: () => onDeleteClick(model),
              ),
              const SizedBox(height: 32),
              SvgIconButton(
                path: "ic_edit",
                size: 24,
                onClick: () => onEditClick(model),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
