import 'package:error_fit/config/extensions/double_extensions.dart';
import 'package:error_fit/config/extensions/string_extensions.dart';
import 'package:error_fit/config/styles/app_colors.dart';
import 'package:error_fit/config/styles/decorations.dart';
import 'package:error_fit/config/styles/font_styles.dart';
import 'package:error_fit/core/buttons/border_button.dart';
import 'package:error_fit/core/buttons/button.dart';
import 'package:error_fit/core/buttons/circle_button.dart';
import 'package:error_fit/core/buttons/like_button.dart';
import 'package:error_fit/core/buttons/my_back_button.dart';
import 'package:error_fit/core/images/ImageLoader.dart';
import 'package:error_fit/core/resources/constants.dart';
import 'package:error_fit/core/widgets/counter_view.dart';
import 'package:error_fit/core/widgets/loading_view.dart';
import 'package:error_fit/core/widgets/my_carousel.dart';
import 'package:error_fit/features/products/details/product_details_control.dart';
import 'package:error_fit/features/products/widgets/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsMobile extends StatelessWidget {
  final ProductDetailsControl control;

  const ProductDetailsMobile({super.key, required this.control});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: LoadingView(
                  controller: control.loadingControl,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _carousel(),
                        _productDetails(),
                        _variants(),
                        _sizes(),
                        _productInfo(),
                        _seller(),
                        _similarProducts(),
                      ],
                    ),
                  ),
                ),
              ),
              _bottomBar(),
            ],
          ),
        ),

        Positioned(top: 0, left: 0, right: 0, child: _appBar()),
      ],
    );
  }

  Widget _appBar() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyBackButton(),
          CircleButton(icon: "ic_share", onClick: control.onShareClick),
        ],
      ),
    );
  }

  Widget _bottomBar() {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            child: BorderButton(
              text: "Add to Cart",
              onClick: control.onAddToCartClick,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Button(text: "Buy Now", onClick: control.onBuyNowClick),
          ),
        ],
      ),
    );
  }

  Widget _carousel() {
    return Obx(() {
      final list = control.carouselList.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MyCarousel(
            height: 450,
            control: control.carouselControl,
            items: list
                .map((e) => ImageLoader(url: e.image.autoUrl, radius: 0))
                .toList(),
          ),
          const SizedBox(height: 10),
          DotListener(
            control: control.carouselControl,
            builder: (index, length, goToPage) => Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 6,
                  children: List.generate(
                    length,
                    (i) => Container(
                      height: 8,
                      width: 8,
                      decoration: Decorations.dot(
                        color: index == i
                            ? AppColors.primary
                            : AppColors.primary70,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _productDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Special Lenin Pant", style: FontStyles.s16Primary7),
          Text(
            "some random description up to 100 characters",
            maxLines: 3,
            style: FontStyles.s16Primary704,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Text(
                          1200.0.formatPrice,
                          style: FontStyles.s14Primary705.copyWith(
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text("20% off", style: FontStyles.s14Green4),
                        ),
                      ],
                    ),
                    Text(899.0.formatPrice, style: FontStyles.s20Black7),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Obx(() {
                return LikeButton(
                  isActive: control.isProductLiked.value,
                  onClick: control.onLikeClick,
                );
              }),
              const SizedBox(width: 10),
              CounterView(
                value: 1,
                onIncrement: control.onIncrementClick,
                onDecrement: control.onDecrementClick,
              ),
              const SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }

  Widget _variants() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text("Variants", style: FontStyles.s16Primary7),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              spacing: 10,
              children: List.generate(
                4,
                (index) => ImageLoader(
                  url: dummyImages[1].autoUrl,
                  radius: 10,
                  height: 90,
                  width: 70,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _sizes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text("Sizes", style: FontStyles.s16Primary7),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              spacing: 10,
              children: ["S", "M", "L", "XL", "XXL"]
                  .map(
                    (e) => Container(
                      decoration: Decorations.card,
                      height: 48,
                      width: 48,
                      child: Center(
                        child: Text(e, style: FontStyles.s16Primary707),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _productInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          Text("Product Info", style: FontStyles.s16Primary7),
          const SizedBox(height: 8),
          Column(
            spacing: 4,
            children: List.generate(
              4,
              (index) => Row(
                children: [
                  Text("Brand : ", style: FontStyles.s14Primary706),
                  Expanded(
                    child: Text("Error Fit", style: FontStyles.s14Primary704),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "some description about product and company",
            style: FontStyles.s14Primary705,
          ),
        ],
      ),
    );
  }

  Widget _seller() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 26),
          Text("Seller", style: FontStyles.s16Primary7),
          const SizedBox(height: 8),
          Container(
            decoration: Decorations.card,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                ImageLoader(url: "", width: 48, height: 48),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("ErrorFit", style: FontStyles.s14Primary6),
                      const SizedBox(height: 2),
                      Text("since 25-07-25", style: FontStyles.s14Primary705),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _similarProducts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 26),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text("Similar Products", style: FontStyles.s16Primary7),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Obx(() {
              final list = control.similarProductsList.value;
              if (list.isEmpty) return Container();
              return Row(
                spacing: 10,
                children: List.generate(
                  list.length,
                  (index) => ProductTile(
                    model: list[index],
                    onClick: control.onSimilarProductClick,
                    onLikeClick: control.onProductLikeClick,
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
