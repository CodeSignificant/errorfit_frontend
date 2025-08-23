import 'package:error_fit/core/resources/screen_view.dart';
import 'package:error_fit/features/wishlist/main/wishlist_controller.dart';
import 'package:error_fit/features/wishlist/main/wishlist_mobile_view.dart';
import 'package:flutter/material.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final control = WishlistController();

  @override
  void initState() {
    control.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenView(mobile: WishlistMobileView(control: control)),
    );
  }
}
