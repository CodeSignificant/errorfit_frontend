import 'package:error_fit/config/extensions/num_extentions.dart';
import 'package:error_fit/config/extensions/string_extensions.dart';
import 'package:error_fit/config/styles/app_colors.dart';
import 'package:error_fit/config/styles/font_styles.dart';
import 'package:error_fit/core/app_bars/footer.dart';
import 'package:error_fit/core/app_bars/main_app_bar.dart';
import 'package:error_fit/core/buttons/anim_button.dart';
import 'package:error_fit/core/buttons/border_button.dart';
import 'package:error_fit/core/buttons/button.dart';
import 'package:error_fit/core/images/ImageLoader.dart';
import 'package:error_fit/core/resources/center_max.dart';
import 'package:error_fit/core/widgets/shimmer_placeholder.dart';
import 'package:error_fit/features/products/details/product_details_control.dart';
import 'package:error_fit/features/products/models/product_details_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/styles/decorations.dart';
import '../../../core/buttons/circle_button.dart';
import '../../../core/buttons/like_button.dart';
import '../../../core/widgets/counter_view.dart';
import '../models/product_model.dart';
import '../widgets/product_tile.dart';

class ProductDetailsWeb extends StatefulWidget {
  final ProductDetailsControl control;

  const ProductDetailsWeb({super.key, required this.control});

  @override
  State<ProductDetailsWeb> createState() => _ProductDetailsWebState();
}

class _ProductDetailsWebState extends State<ProductDetailsWeb> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MainAppBar(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CenterMax(
                  child: Obx(() {
                    final details = widget.control.details.value;
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 16),
                        _images(details.images),
                        const SizedBox(width: 48),
                        Expanded(child: _details(details)),
                        const SizedBox(width: 16),
                      ],
                    );
                  }),
                ),
                const SizedBox(height: 48),
                Footer(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _images(List<String> images) {
    if (images.isEmpty) return ShimmerPlaceholder(width: 600, height: 600);
    return Container(
      constraints: BoxConstraints(
        maxWidth: 600.ratio(context, 450, 600),
        maxHeight: 600,
      ),
      child: Obx(() {
        final selectedImage = widget.control.selectedImage.value;
        return Row(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 10,
                  children: List.generate(
                    images.length,
                    (index) => AnimButton(
                      onClick: () =>
                          widget.control.onImageSelect(images[index]),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: images[index] == selectedImage
                                ? AppColors.link
                                : AppColors.transparent,
                          ),
                        ),
                        padding: const EdgeInsets.all(1),
                        child: ImageLoader(
                          url: images[index].autoUrl,
                          height: 200,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ImageLoader(
                url: selectedImage.autoUrl,
                width: 450,
                height: 600,
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _details(ProductDetailsModel details) {
    return Container(
      constraints: BoxConstraints(minWidth: 400),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(child: Text(details.title, style: FontStyles.s24Primary7)),
              const SizedBox(width: 10),
              CircleButton(
                icon: "ic_share",
                onClick: widget.control.onShareClick,
              ),
            ],
          ),
          const SizedBox(height: 6),

          Text(details.description, style: FontStyles.s16Primary704),
          const SizedBox(height: 26),

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
                          child: Text(
                            "${details.sellingPrice.percentageOf(details.mrpPrice)} Off",
                            style: FontStyles.s14Green4,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      details.sellingPrice.formatPrice,
                      style: FontStyles.s20Black7,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Obx(() {
                return LikeButton(
                  isActive: widget.control.isProductLiked.value,
                  onClick: widget.control.onLikeClick,
                );
              }),
              const SizedBox(width: 10),
              Obx(() {
                return CounterView(
                  value: widget.control.counter.value,
                  onIncrement: widget.control.onIncrementClick,
                  onDecrement: widget.control.onDecrementClick,
                );
              }),
              const SizedBox(width: 10),
            ],
          ),
          const SizedBox(height: 16),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _variants(details.variants),
                    _sizes(details.sizes),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Visibility(
                visible: MediaQuery.of(context).size.width > 1140,
                child: Container(
                  constraints: BoxConstraints(maxWidth: 200),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 16,
                    children: [
                      const SizedBox(height: 1),
                      BorderButton(
                        text: "Add Cart",
                        onClick: widget.control.onAddToCartClick,
                      ),
                      Button(
                        onClick: widget.control.onBuyNowWebClick,
                        text: "Buy Now",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Visibility(
            visible: MediaQuery.of(context).size.width <= 1140,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 16,
              children: [
                const SizedBox(height: 1),
                BorderButton(
                  text: "Add Cart",
                  onClick: widget.control.onAddToCartClick,
                ),
                Button(
                  onClick: widget.control.onBuyNowWebClick,
                  text: "Buy Now",
                ),
              ],
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.width <= 1140 ? 16 : 0),

          _productInfo(details.info),

          _seller(details.seller),

          _similarProducts(details.similar),
          const SizedBox(height: 16),
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
                (index) => AnimButton(
                  onClick: () => widget.control.onVariantClick(variants[index]),
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
                    (e) => AnimButton(
                      onClick: () => widget.control.onSizeClick(e),
                      child: Container(
                        decoration: Decorations.card,
                        height: 48,
                        width: 48,
                        child: Center(
                          child: Text(
                            e.size.toUpperCase(),
                            style: FontStyles.s16Primary707,
                          ),
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
              (index) => Row(
                children: [
                  Text(
                    "${info.details[index].title} : ",
                    style: FontStyles.s14Primary706,
                  ),
                  Expanded(
                    child: Text(
                      info.details[index].title,
                      style: FontStyles.s14Primary704,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(info.info, style: FontStyles.s14Primary705),
        ],
      ),
    );
  }

  Widget _seller(Seller seller) {
    return Align(
      alignment: AlignmentGeometry.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: 400),
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
                  ImageLoader(
                    url: seller.logoUrl.autoUrl,
                    width: 48,
                    height: 48,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(seller.name, style: FontStyles.s14Primary6),
                        const SizedBox(height: 2),
                        Text(
                          "since ${seller.createdAt}",
                          style: FontStyles.s14Primary705,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
              (index) => ProductTile(
                model: products[index],
                onClick: widget.control.onSimilarProductClick,
                onLikeClick: widget.control.onProductLikeClick,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
