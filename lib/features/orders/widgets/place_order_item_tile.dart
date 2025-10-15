import 'package:error_fit/config/extensions/int_extensions.dart';
import 'package:error_fit/config/extensions/string_extensions.dart';
import 'package:error_fit/config/styles/decorations.dart';
import 'package:error_fit/config/styles/font_styles.dart';
import 'package:error_fit/core/images/ImageLoader.dart';
import 'package:error_fit/features/orders/models/pre_order_model.dart';
import 'package:flutter/material.dart';

class PlaceOrderItemTile extends StatelessWidget {
  final PreOrderModel model;

  const PlaceOrderItemTile({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: Decorations.card,
      child: Row(
        children: [
          ImageLoader(url: model.previewUrl.autoUrl, width: 120, height: 120),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  model.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: FontStyles.s18Primary5,
                ),
                const SizedBox(height: 2),
                Text("- ${model.brand}", style: FontStyles.s14Primary5),
                const SizedBox(height: 2),
                Text("Size: ${model.size}", style: FontStyles.s14Primary705),
                const SizedBox(height: 2),
                Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(model.mrpPrice.formatPrice, style: FontStyles
                                  .s12Primary704.copyWith(
                                  decoration: TextDecoration.lineThrough)),
                          Text(
                              model.price.formatPrice,
                              style: FontStyles.s12Primary704),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "${model.items} Items",
                            textAlign: TextAlign.end,
                            style: FontStyles.s14Primary704,
                          ),
                          Text((model.price * model.items).formatPrice,
                            textAlign: TextAlign.end,
                            style: FontStyles.s16Primary7,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
