import 'package:error_fit/config/styles/app_colors.dart';
import 'package:error_fit/core/buttons/button.dart';
import 'package:error_fit/core/buttons/check_tile.dart';
import 'package:error_fit/core/buttons/radio_tile.dart';
import 'package:error_fit/core/widgets/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'filter_controller.dart';

class FilterView extends StatefulWidget {
  final FilterController controller;

  const FilterView({super.key, required this.controller});

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.controller.onInit();
    },);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: LoadingView(
            controller: widget.controller.loadingController,
            child: Obx(() {
              return ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: widget.controller.filters.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (_, i) {
                  final item = widget.controller.filters[i];
                  return _buildFilterItem(context, item);
                },
              );
            }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: widget.controller.onClearAllClick,
                child: const Text(
                    "Clear", style: TextStyle(fontWeight: FontWeight.w600)),
              ),
              Button(
                  onClick: widget.controller.onApplyClick,

                  text: "Apply"
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildFilterItem(BuildContext context, Map<String, dynamic> item) {
    switch (item['type']) {
      case 'multi':
        return _multi(item);
      case 'single':
        return _single(item);
      case 'range':
        return _range(context, item);
      case 'linked-2':
        return _linkedTwoLevel(item);
      default:
        return const SizedBox();
    }
  }

  Widget _multi(Map<String, dynamic> item) {
    final options = List<String>.from(item['options'] ?? []);
    final selected = List<String>.from(item['selected'] ?? []);
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            item['label'], style: const TextStyle(fontWeight: FontWeight.bold)),
        ...options.map((e) =>
            CheckTile(
                title: e,
                active: selected.contains(e),
                onClick: () =>
                    widget.controller.onCheckChange(
                        !selected.contains(e), e, item)
            ))
      ],
    );
  }

  Widget _single(Map<String, dynamic> item) {
    final options = List<String>.from(item['options'] ?? []);
    final selected = item['selected'];
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            item['label'], style: const TextStyle(fontWeight: FontWeight.bold)),
        ...options.map((e) =>
            RadioTile(
              active: e == selected,
              title: e,
              onClick: () => widget.controller.onRadioChange(e, item),
            ))
      ],
    );
  }

  Widget _range(BuildContext context, Map<String, dynamic> item) {
    final min = (item['min'] ?? 0).toDouble();
    final max = (item['max'] ?? 10000).toDouble();

    // Fix: ensure two values always exist
    List<num> selected = List<num>.from(item['selected'] ?? []);
    if (selected.length < 2) selected = [min, max];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
            "${item['label']} ₹${selected.first} - ${selected.last}",
            style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10,),
        RangeSlider(
          min: min,
          max: max,
          values: RangeValues(selected[0].toDouble(), selected[1].toDouble()),
          activeColor: AppColors.primary,
          inactiveColor: AppColors.primary25,
          labels: RangeLabels("${selected[0]}", "${selected[1]}"),
          onChanged: (r) => widget.controller.onRangeChange(r, item),
        ),
      ],
    );
  }

  Widget _linkedTwoLevel(Map<String, dynamic> item) {
    final Map<String, dynamic> options = Map<String, dynamic>.from(
        item['options'] ?? {});
    final selectedMain = List<String>.from(item['selected_link1'] ?? []);
    final selectedSub = List<String>.from(item['selected_link2'] ?? []);

    // Determine which main categories to display subcategories for
    final List<String> mainForSub = selectedMain.isNotEmpty
        ? selectedMain
        : [
      options.keys.first
    ]; // default to first main category if none selected

    // Combine sub-options of mainForSub
    final Set<String> subOptions = {};
    for (final main in mainForSub) {
      final children = List<String>.from(options[main] ?? []);
      subOptions.addAll(children);
    }

    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            item['label'], style: const TextStyle(fontWeight: FontWeight.bold)),

        // Main Categories
        ...options.keys.map((mainCat) {
          final isActive = selectedMain.contains(mainCat);
          return CheckTile(
            title: mainCat,
            active: isActive,
            onClick: () =>
                widget.controller.onLinkedMainChange(!isActive, mainCat, item),
          );
        }),

        // Subcategories
        if (subOptions.isNotEmpty) ...[
          const SizedBox(height: 1),
          const Text(
              "Sub Categories", style: TextStyle(fontWeight: FontWeight.bold)),
          // const SizedBox(height: 8),
          ...subOptions.map((subCat) {
            final isActive = selectedSub.contains(subCat);
            return CheckTile(
              title: subCat,
              active: isActive,
              onClick: () =>
                  widget.controller.onLinkedSubChange(!isActive, subCat, item),
            );
          }),
        ]
      ],
    );
  }
}
