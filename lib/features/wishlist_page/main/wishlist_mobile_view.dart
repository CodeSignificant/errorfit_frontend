import 'package:error_fit/core/app_bars/title_appbar.dart';
import 'package:error_fit/core/resources/actions.dart';
import 'package:error_fit/core/widgets/loading_view.dart';
import 'package:error_fit/features/wishlist_page/main/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/resources/stretch_grid.dart';
import '../../products/widgets/product_tile.dart';

class WishlistMobileView extends StatefulWidget {
  final WishlistController control;

  const WishlistMobileView({super.key, required this.control});

  @override
  State<WishlistMobileView> createState() => _WishlistMobileViewState();
}

class _WishlistMobileViewState extends State<WishlistMobileView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TitleAppBar(title: "Wishlist"),
        Expanded(
          child: Obx(() {
            final list = widget.control.productsList.value;
            return LoadingView(
              controller: widget.control.loadingControl,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 12,
                  ),
                  child: StretchGrid(
                    spacing: 10,
                    crossAxisCount: 2,
                    children: List.generate(
                      list.length,
                      (index) => ProductTile(
                        model: list[index],
                        onClick: widget.control.onProductClick,
                        onLikeClick: widget.control.onProductLikeClick,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        SizedBox(height: kBottomBarHeight),
      ],
    );
  }
}
