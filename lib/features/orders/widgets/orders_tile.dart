import 'package:error_fit/config/extensions/string_extensions.dart';
import 'package:error_fit/config/styles/decorations.dart';
import 'package:error_fit/config/styles/font_styles.dart';
import 'package:error_fit/core/buttons/anim_button.dart';
import 'package:error_fit/core/images/ImageLoader.dart';
import 'package:error_fit/features/orders/orders_model.dart';
import 'package:flutter/material.dart';

class OrdersTile extends StatelessWidget {
  final OrderModel model;
  final Function(OrderModel model) onClick;

  const OrdersTile({super.key, required this.model, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return AnimButton(
      onClick: () => onClick(model),
      child: Container(
        decoration: Decorations.card,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          spacing: 10,
          children: [
            ImageLoader(url: model.previewUrl.autoUrl, width: 100, height: 100),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 4,
                children: [
                  Text(model.title, style: FontStyles.s14Primary6),
                  Text("Items: ${model.quantity}", style: FontStyles.s14Primary704),
                  Text(model.status, style: FontStyles.s14Green4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
