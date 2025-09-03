import 'package:get/get.dart';

class FilterController extends GetxController {
  final filter = [
    {
      "title": "Categories",
      "type": "multiple",
      "options": ["T Shirts", "Hoodies", "Traditional"],
      "id": "categories",
      "refresh": true,
      "selected": [],
    },
    {
      "title": "Brands",
      "type": "multiple",
      "options": ["ErrorFit", "VARKAS", "BearBadge", "RomanIsland"],
      "id": "brands",
      "selected": [],
    },
    {
      "title": "Sizes",
      "type": "multiple",
      "options": ["S", "M", "L", "XL", "XXL"],
      "id": "sizes",
      "selected": [],
    },
    {
      "title": "Price",
      "type": "multiple",
      "options": ["99-299", "300-499", "500-699", "700 Above"],
      "id": "price",
      "selected": [],
    },
    {
      "title": "Sort By",
      "type": "radio",
      "options": ["Popular", "New Launch"],
      "id": "sort",
      "selected": "",
    },
  ].obs;

  void onFilterCheckChange(
    bool? value,
    String selected,
    Map<String, Object> item,
  ) {
    // Safely get the current selected list as List<String>
    List<String> selectedOptions =
        (item['selected'] as List<dynamic>?)?.whereType<String>().toList() ??
        [];

    if (value == true) {
      // Add selected option if not already in the list
      if (!selectedOptions.contains(selected)) {
        selectedOptions = [...selectedOptions, selected];
      }
    } else {
      // Remove the option if unchecked
      selectedOptions = selectedOptions.where((e) => e != selected).toList();
    }

    // Update the item map with the new selected list
    item['selected'] = selectedOptions;

    // Refresh the observable list to trigger UI update
    filter.refresh();
  }

  void onFilterRadioChange(
    bool? value,
    String option,
    Map<String, Object> item,
  ) {
    item['selected'] = (value ?? false) ? option : "";
    filter.refresh();
  }
}
