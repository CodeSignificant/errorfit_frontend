import 'package:error_fit/config/extensions/string_extensions.dart';
import 'package:error_fit/config/styles/app_colors.dart';
import 'package:error_fit/config/styles/decorations.dart';
import 'package:error_fit/config/styles/font_styles.dart';
import 'package:error_fit/core/buttons/anim_button.dart';
import 'package:error_fit/core/buttons/border_button.dart';
import 'package:error_fit/core/buttons/button.dart';
import 'package:error_fit/core/buttons/circle_button.dart';
import 'package:error_fit/core/buttons/like_button.dart';
import 'package:error_fit/core/buttons/my_back_button.dart';
import 'package:error_fit/core/images/ImageLoader.dart';
import 'package:error_fit/core/resources/actions.dart';
import 'package:error_fit/core/widgets/counter_view.dart';
import 'package:error_fit/core/widgets/loading_view.dart';
import 'package:error_fit/core/widgets/my_carousel.dart';
import 'package:error_fit/features/products/details/product_details_control.dart';
import 'package:error_fit/features/products/models/product_details_model.dart';
import 'package:error_fit/features/products/models/product_model.dart';
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
          child: Obx(() {
            final details = control.details.value;
            return Column(
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
                          _productDetails(details),
                          _variants(details.variants),
                          _sizes(details.sizes),
                          _productInfo(details.info),
                          _seller(details.seller),
                          _similarProducts(details.similar),
                          const SizedBox(height: 16,),
                        ],
                      ),
                    ),
                  ),
                ),
                _bottomBar(),
                SizedBox(height: kBottomBarHeight,)
              ],
            );
          }),
        ),

        Positioned(top: 0, left: 0, right: 0, child: _appBar()),
      ],
    );
  }

  Widget _appBar() {
    return Padding(
      padding: EdgeInsets.only(
        left: 12.0,
        right: 12,
        bottom: 12,
        top: 12 + kStatusBarHeight,
      ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        MyCarousel(
          height: 450,
          control: control.carouselControl,
          // items: list
          //     .map((e) => ImageLoader(url: e.image.autoUrl, radius: 0))
          //     .toList(),
          builder: (int index, int length, item) =>
              ImageLoader(url: (item as String).autoUrl, radius: 0,),
        ),
        const SizedBox(height: 10),
        DotListener(
          control: control.carouselControl,
          builder: (index, length, goToPage) =>
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 6,
                    children: List.generate(
                      length,
                          (i) =>
                          Container(
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
  }

  Widget _productDetails(ProductDetailsModel details) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(details.title, style: FontStyles.s16Primary7),
          Text(
            details.description,
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
                          details.mrpPrice.formatPrice,
                          style: FontStyles.s14Primary705.copyWith(
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text("${details.sellingPrice.percentageOf(
                              details.mrpPrice)} Off",
                              style: FontStyles.s14Green4),
                        ),
                      ],
                    ),
                    Text(details.sellingPrice.formatPrice,
                        style: FontStyles.s20Black7),
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
              Obx(() {
                return CounterView(
                  value: control.counter.value,
                  onIncrement: control.onIncrementClick,
                  onDecrement: control.onDecrementClick,
                );
              }),
              const SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }

  Widget _variants(List<Variant> variants) {
    if (variants.isEmpty) return SizedBox();
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
                variants.length,
                    (index) =>
                    AnimButton(
                      onClick: () => control.onVariantClick(variants[index]),
                      child: ImageLoader(
                        url: variants[index].previewUrl.autoUrl,
                        radius: 10,
                        height: 90,
                        width: 70,
                      ),
                    ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _sizes(List<SizeOption> sizes) {
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
              children: sizes
                  .map(
                    (e) =>
                    AnimButton(
                      onClick: () => control.onSizeClick(e),
                      child: Container(
                        decoration: Decorations.card,
                        height: 48,
                        width: 48,
                        child: Center(
                          child: Text(e.size.toUpperCase(),
                              style: FontStyles.s16Primary707),
                        ),
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

  Widget _productInfo(ProductInfo info) {
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
              info.details.length,
                  (index) =>
                  Row(
                    children: [
                      Text("${info.details[index].title} : ",
                          style: FontStyles.s14Primary706),
                      Expanded(
                        child: Text(
                            info.details[index].title,
                            style: FontStyles.s14Primary704),
                      ),
                    ],
                  ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            info.info,
            style: FontStyles.s14Primary705,
          ),
        ],
      ),
    );
  }

  Widget _seller(Seller
  seller) {
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
                ImageLoader(url: seller.logoUrl.autoUrl, width: 48, height: 48),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(seller.name, style: FontStyles.s14Primary6),
                      const SizedBox(height: 2),
                      Text("since ${seller.createdAt}",
                          style: FontStyles.s14Primary705),
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

  Widget _similarProducts(List<ProductModel> products) {
    if (products.isEmpty) return Container();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 26),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text("Similar Products", style: FontStyles.s16Primary7),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            spacing: 10,
            children: List.generate(
              products.length,
                  (index) =>
                  ProductTile(
                    model: products[index],
                    onClick: control.onSimilarProductClick,
                    onLikeClick: control.onProductLikeClick,
                  ),
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
