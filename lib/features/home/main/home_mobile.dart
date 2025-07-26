import 'package:error_fit/config/enums/bottom_nav_types.dart';
import 'package:error_fit/core/app_bars/my_bottom_nav_bar.dart';
import 'package:error_fit/features/auth/profile_section/profile_section.dart';
import 'package:error_fit/features/cart/section/cart_section.dart';
import 'package:error_fit/features/home/main/home_controller.dart';
import 'package:error_fit/features/home/section/home_section.dart';
import 'package:error_fit/features/search/main/search_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeMobile extends StatefulWidget {
  final HomeController control;

  const HomeMobile({super.key, required this.control});

  @override
  State<HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Obx(() {
            BottomNavTypes activeTab = widget.control.activeTab.value;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if(activeTab == BottomNavTypes.home) Expanded(
                    child: HomeSection()),
                if(activeTab == BottomNavTypes.search) Expanded(
                    child: SearchSection()),
                if(activeTab == BottomNavTypes.cart) Expanded(
                    child: CartSection()),
                if(activeTab == BottomNavTypes.profile) Expanded(
                    child: ProfileSection()),
              ],
            );
          }),
        ),
        MyBottomNavBar(selectedType: widget.control.activeTab.value,
          onSelect: widget.control.onBottomNavSelect,)
      ],
    );
  }
}
