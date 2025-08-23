import 'package:error_fit/config/styles/app_colors.dart';
import 'package:error_fit/core/buttons/svg_icon_button.dart';
import 'package:error_fit/core/images/svg_icon.dart';
import 'package:error_fit/core/resources/actions.dart';
import 'package:error_fit/core/resources/stretch_grid.dart';
import 'package:error_fit/core/widgets/loading_view.dart';
import 'package:error_fit/features/products/widgets/product_tile.dart';
import 'package:error_fit/features/search/products/products_search_control.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsSearchMobile extends StatefulWidget {
  final ProductsSearchControl control;

  const ProductsSearchMobile({super.key, required this.control});

  @override
  State<ProductsSearchMobile> createState() => _ProductsSearchMobileState();
}

class _ProductsSearchMobileState extends State<ProductsSearchMobile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: AppColors.white,
          height: kToolbarHeight + kStatusBarHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: kStatusBarHeight),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 14),
                    SvgIconButton(path: "ic_ios_left",
                        size: 24,
                        onClick: widget.control.onBackClick),
                    const SizedBox(width: 14),
                    Expanded(
                        child: TextFormField(
                          controller: widget.control.searchControl,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search",
                          ),
                          focusNode: widget.control.searchFocus,
                        )),
                    SvgIconButton(
                      onClick: widget.control.onSearchIconClick,
                      padding: 0,
                      path: "ic_search", size: 20, color: AppColors.primary,),
                    const SizedBox(width: 10),
                    SvgIconButton(onClick: widget.control.onFilterClick, path: "ic_menu", color: AppColors.primary,),
                    const SizedBox(width: 14),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: LoadingView(
            controller: widget.control.loadingControl,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16,),
                  Obx(() {
                    final list = widget.control.productsList.value;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
                    );
                  }),
                  const SizedBox(height: 16,),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: kBottomBarHeight,)
      ],
    );
  }
}
