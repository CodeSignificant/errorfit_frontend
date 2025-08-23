import 'package:error_fit/config/styles/app_colors.dart';
import 'package:error_fit/core/app_bars/main_app_bar.dart';
import 'package:error_fit/core/resources/stretch_grid.dart';
import 'package:error_fit/core/widgets/loading_view.dart';
import 'package:error_fit/features/search/filter/filter_view.dart';
import 'package:error_fit/features/search/products/products_search_control.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../products/widgets/product_tile.dart';

class ProductSearchWebView extends StatefulWidget {
  final ProductsSearchControl control;

  const ProductSearchWebView({super.key, required this.control});

  @override
  State<ProductSearchWebView> createState() => _ProductSearchWebViewState();
}

class _ProductSearchWebViewState extends State<ProductSearchWebView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MainAppBar(),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 300,
                color: AppColors.white,
                child: FilterView(),
              ),
              Expanded(
                child: LoadingView(
                  controller: widget.control.loadingControl,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(12),
                    child: Obx(() {
                      final list = widget.control.productsList.value;
                      return StretchGrid(
                        crossAxisCount: _getCount(context),
                        children: List.generate(
                          list.length,
                          (index) => ProductTile(
                            model: list[index],
                            onClick: widget.control.onProductClick,
                            onLikeClick: widget.control.onProductLikeClick,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  int _getCount(BuildContext context) {
    final sWidth = MediaQuery.of(context).size.width;
    if(sWidth>1220) return 5;
    if(sWidth>1050) return 4;
    return 3;
  }
}
