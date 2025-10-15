import 'package:error_fit/core/network/repo/products/filter_products_repo.dart';
import 'package:error_fit/core/resources/actions.dart';
import 'package:error_fit/core/resources/data_response.dart';
import 'package:error_fit/core/widgets/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  final filters = <Map<String, dynamic>>[].obs;
  final loadingController = LoadingViewController();

  void Function({required dynamic filters})? _onApplyCallback;

  @override
  void onInit() {
    super.onInit();
    if (filters.isEmpty) {
      _loadFilterJson();
    }
  }

  applyListener(void Function({required dynamic filters})? callback) {
    _onApplyCallback = callback;
  }

  void _loadFilterJson() async {
    final result = await FilterProductsRepo.filterJson();
    if (result is DataFailed) {
      loadingController.setError("Something went wrong\nPlease retry");
      return;
    }
    if (result is DataSuccess) {
      filters.assignAll(
        (result.data!['filters'] as List<dynamic>)
            .map((e) => Map<String, dynamic>.from(e as Map))
            .toList(),
      );
      loadingController.setLoading(false);
      return;
    }
  }

  void onCheckChange(bool? value, String option, Map<String, dynamic> item) {
    final selected = List<String>.from(item['selected'] ?? []);
    if (value == true) {
      if (!selected.contains(option)) selected.add(option);
    } else {
      selected.remove(option);
    }
    item['selected'] = selected;
    filters.refresh();
  }

  void onRadioChange(String option, Map<String, dynamic> item) {
    item['selected'] = option;
    filters.refresh();
  }

  void onRangeChange(RangeValues range, Map<String, dynamic> item) {
    item['selected'] = [range.start.round(), range.end.round()];
    filters.refresh();
  }

  void onLinkedMainChange(bool add, String mainCat, Map<String, dynamic> item) {
    final selectedMain = List<String>.from(item['selected_link1'] ?? []);

    if (add) {
      if (!selectedMain.contains(mainCat)) selectedMain.add(mainCat);
    } else {
      selectedMain.remove(mainCat);
    }
    item['selected_link1'] = selectedMain;

    // Auto-cleanup: remove invalid subcategories
    final allOptions = Map<String, dynamic>.from(item['options'] ?? {});
    final allowedSubs = selectedMain
        .expand((main) => allOptions[main] ?? [])
        .toSet();
    final selectedSubs = List<String>.from(item['selected_link2'] ?? []);
    item['selected_link2'] = selectedSubs
        .where((s) => allowedSubs.contains(s))
        .toList();

    filters.refresh();
  }

  void onLinkedSubChange(bool add, String subCat, Map<String, dynamic> item) {
    final selectedSubs = List<String>.from(item['selected_link2'] ?? []);

    if (add) {
      if (!selectedSubs.contains(subCat)) selectedSubs.add(subCat);
    } else {
      selectedSubs.remove(subCat);
    }

    item['selected_link2'] = selectedSubs;
    filters.refresh();
  }

  void onClearAllClick() {
    for (var item in filters) {
      if (item['type'] == 'multi') item['selected'] = [];
      if (item['type'] == 'single') item['selected'] = '';
      if (item['type'] == 'range' &&
          (item['selected'] == null || item['selected'].isEmpty)) {
        item['selected'] = [item['min'], item['max']];
      }
      if (item['type'] == 'linked-2') {
        item['selected_link1'] = [];
        item['selected_link2'] = [];
      }
    }
    filters.refresh();
    _onApplyCallback?.call(filters: null);
    closeDialog();
  }

  void onApplyClick() {
    _onApplyCallback?.call(filters: getSelectedFilters());
    closeDialog();
  }

  Map<String, dynamic> getSelectedFilters() {
    final Map<String, dynamic> result = {};

    for (final item in filters) {
      final key = item['key'];
      final type = item['type'];

      if (type == "multi") {
        final selected = List<String>.from(item['selected'] ?? []);
        if (selected.isNotEmpty) {
          result[key] = selected;
        }
      } else if (type == "single") {
        final selected = item['selected'];
        if (selected != null && selected.toString().isNotEmpty) {
          result[key] = selected;
        }
      } else if (type == "range") {
        final selected = List<num>.from(item['selected'] ?? []);
        if (selected.isNotEmpty &&
            (selected.first != item['min'] || selected.last != item['max'])) {
          result[key] = selected;
        }
      } else if (type == "linked-2") {
        // Handle linked-2: only include selected sub_categories
        final subSelected = List<String>.from(item['selected_link2'] ?? []);
        if (subSelected.isNotEmpty) {
          result['sub_category'] = subSelected;
        }

        final mainSelected = List<String>.from(item['selected_link1'] ?? []);
        if (mainSelected.isNotEmpty) {
          result['main_category'] = mainSelected;
        }
      } else if (type == "color") {
        final color = item['selected']; // can be name or RGB
        if (color != null && color.toString().isNotEmpty) {
          result[key] = color;
        }
      }
    }

    return result;
  }
}
