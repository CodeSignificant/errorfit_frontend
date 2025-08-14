import 'package:error_fit/config/extensions/double_extensions.dart';
import 'package:error_fit/config/extensions/string_extensions.dart';
import 'package:error_fit/config/styles/decorations.dart';
import 'package:error_fit/config/styles/font_styles.dart';
import 'package:error_fit/core/buttons/anim_button.dart';
import 'package:error_fit/core/buttons/like_button.dart';
import 'package:error_fit/core/images/ImageLoader.dart';
import 'package:error_fit/features/products/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductTile extends StatelessWidget {
  final ProductModel model;
  final Function(ProductModel model) onClick;
  final Function(ProductModel model) onLikeClick;

  const ProductTile({
    super.key,
    required this.model,
    required this.onClick,
    required this.onLikeClick,
  });

  @override
  Widget build(BuildContext context) {
    return AnimButton(
      onClick: () => onClick(model),
      child: Container(
        constraints: BoxConstraints(maxWidth: 180),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ImageLoader(
              url: model.image.autoUrl,
              height: 200,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            Container(
              decoration: Decorations.bottomBorder,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(model.title, style: FontStyles.s20Black4),
                  Text(model.brand, style: FontStyles.s14Primary705),

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
                                  model.mrpPrice.formatPrice,
                                  style: FontStyles.s14Primary706.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    "${model.offer}% off",
                                    style: FontStyles.s14Green6,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              model.sellingPrice.formatPrice,
                              style: FontStyles.s20Black6,
                            ),
                          ],
                        ),
                      ),
                      Obx(() {
                        return LikeButton(
                          isActive: model.isLiked.value,
                          onClick: _onLikeClick,
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onLikeClick(bool value) {
    model.isLiked.value = value;
    onLikeClick(model);
  }
}
