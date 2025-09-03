import 'package:error_fit/config/styles/font_styles.dart';
import 'package:error_fit/core/buttons/check_button.dart';
import 'package:error_fit/core/buttons/radio_button.dart';
import 'package:error_fit/features/search/filter/filter_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/buttons/button.dart';

class FilterView extends StatefulWidget {
  const FilterView({super.key});

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {

  final control = FilterController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _filterGenerator()
                  ]),
            )),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Clear"),
              Button(onClick: onFilterApplyClick, text: "Apply"),
            ],
          ),
        ),
      ],
    );
  }

  void onFilterApplyClick() {}

  Widget _filterGenerator() {
    return Obx(() {
      final filter = control.filter.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12,
        children: List.generate(filter.length, (index) {
          final item = filter[index];

          // Fix: Safely cast options from dynamic list to List<String>
          List<String> options = (item["options"] as List<dynamic>?)
              ?.whereType<String>()
              .toList() ??
              [];

          if (item['type'] == "multiple") {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "${item['title'] ?? "NA"}",
                  style: FontStyles.s14Primary704,
                ),
                const SizedBox(height: 8,),

                // Use CheckboxListTile for better tappable area and clearer UI
                ...List.generate(options.length, (index) {
                  final option = options[index];
                  // Fix: Safely cast selected list with null check and type filtering
                  List<String> selected = (item['selected'] as List<dynamic>?)
                      ?.whereType<String>()
                      .toList() ??
                      [];

                  return Row(
                    children: [
                      CheckButton(isActive: selected.contains(option),
                          onClick: (bool? value) {
                            // Call controller method passing mutable item and current option
                            control.onFilterCheckChange(value, option, item);
                          }),
                      const SizedBox(width: 4,),
                      Expanded(child: Text(option,
                        style: FontStyles.s14Primary5,))
                    ],
                  );
                }),
              ],
            );
          }

          if (item['type'] == "radio") {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "${item['title'] ?? "NA"}",
                  style: FontStyles.s14Primary704,
                ),
                const SizedBox(height: 8,),

                // Use CheckboxListTile for better tappable area and clearer UI
                ...List.generate(options.length, (index) {
                  final option = options[index];
                  return Row(
                    children: [
                      RadioButton(isActive: item['selected'] == option,
                          size: 26,
                          onClick: (bool? value) {
                            // Call controller method passing mutable item and current option
                            control.onFilterRadioChange(value, option, item);
                          }),
                      const SizedBox(width: 8,),
                      Expanded(child: Text(option,
                        style: FontStyles.s14Primary5,))
                    ],
                  );
                }),
              ],
            );
          }

          // Return empty box for unknown types
          return const SizedBox(
          );
        }),
      );
    });
  }

}
