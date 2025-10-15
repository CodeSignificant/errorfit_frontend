import 'package:error_fit/config/extensions/double_extensions.dart';
import 'package:error_fit/config/extensions/string_extensions.dart';
import 'package:error_fit/config/styles/decorations.dart';
import 'package:error_fit/config/styles/font_styles.dart';
import 'package:error_fit/core/buttons/anim_button.dart';
import 'package:error_fit/core/buttons/radio_check.dart';
import 'package:error_fit/core/images/ImageLoader.dart';
import 'package:error_fit/features/cart/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/counter_view.dart';

class CartTile extends StatelessWidget {
  final CartModel model;
  final Function(CartModel model) onClick;
  final Function(CartModel model)? onChangeListener;
  final Function(CartModel model)? onRemoveClick;

  const CartTile(
      {super.key, required this.model, required this.onClick, this.onChangeListener, this.onRemoveClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: Decorations.card,
      child: Row(
        children: [
          AnimButton(
            onClick: () => onClick(model),
            child: ImageLoader(
              url: model.image.autoUrl,
              width: 120,
              height: 120,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(model.title, style: FontStyles.s18Primary5),
                          const SizedBox(height: 2),
                          Text(
                            "- ${model.brand}",
                            style: FontStyles.s14Primary5,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Size: ${model.size}",
                            style: FontStyles.s14Primary705,
                          ),
                        ],
                      ),
                    ),
                    Obx(() {
                      return RadioCheck(
                        isActive: model.isSelect.value,
                        onClick: _onSelectRadioChange,
                        size: 28,
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        model.price.formatPrice,
                        style: FontStyles.s20Black7,
                      ),
                    ),
                    Obx(() {
                      return CounterView(
                        value: model.count.value,
                        onIncrement: _onIncrementClick,
                        onDecrement: _onDecrementClick,
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _onSelectRadioChange(bool isActive) {
    model.toggleSelect();
    onChangeListener?.call(model);
  }

  _onIncrementClick(int value) {
    if(value == 11) return;
    model.increment();
    onChangeListener?.call(model);
  }
  _onDecrementClick(int value) {
    if (value == 0) {
      onRemoveClick?.call(model);
      return;
    }
    model.decrement();
    onChangeListener?.call(model);
  }
}
