import 'package:error_fit/config/enums/bottom_nav_types.dart';
import 'package:error_fit/config/styles/app_colors.dart';
import 'package:error_fit/core/buttons/anim_button.dart';
import 'package:error_fit/core/images/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyBottomNavBar extends StatefulWidget {
  final BottomNavTypes selectedType;
  final Function(BottomNavTypes type) onSelect;

  const MyBottomNavBar({
    super.key,
    required this.selectedType,
    required this.onSelect,
  });

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  final Rx<BottomNavTypes> _selectedType = BottomNavTypes.home.obs;

  @override
  void initState() {
    _selectedType.value = widget.selectedType;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.white),
      child: Obx(() {
        return Row(
          children: BottomNavTypes.values
              .map(
                (e) => Expanded(
                  child: AnimButton(
                    onClick: () => _onTabSelect(e),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 12),
                        SvgIcon(
                          path: _findIcon(e),
                          color: e == _selectedType.value
                              ? AppColors.primary
                              : AppColors.primary70,
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        );
      }),
    );
  }

  void _onTabSelect(BottomNavTypes type) {
    _selectedType.value = type;
    widget.onSelect(type);
  }

  _findIcon(BottomNavTypes e) {
    if (e == BottomNavTypes.search) return "ic_search";
    if (e == BottomNavTypes.cart) return "ic_cart";
    if (e == BottomNavTypes.profile) return "ic_profile";
    return "ic_home";
  }
}
