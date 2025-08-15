import 'package:error_fit/core/resources/constants.dart';
import 'package:get/get.dart';

import '../../../core/resources/actions.dart';

class CartModel {
  final String title;
  final String brand;
  final String size;
  final double price;
  final String image;
  final int maxLimit;
  final String id;

  RxBool isSelect;
  RxInt count;

  CartModel({
    required this.title,
    required this.brand,
    required this.size,
    required this.price,
    required this.maxLimit,
    required this.image,
    required this.id,
    bool isSelect = true,
    int count = 1,
  }) : isSelect = isSelect.obs,
       count = count.obs;

  /// Increment count up to maxLimit
  void increment() {
    if (count.value < maxLimit) {
      count.value++;
    }
  }

  /// Decrement count but not below 1
  void decrement() {
    if (count.value > 1) {
      count.value--;
    }
  }

  /// Toggle selection state
  void toggleSelect() {
    isSelect.toggle();
  }

  /// Convert from JSON
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      title: json['title'] ?? '',
      brand: json['brand'] ?? '',
      size: json['size'] ?? '',
      price: json['selling_price'] is double
          ? json['selling_price']
          : double.tryParse(json['selling_price']?.toString() ?? '') ?? 0.0,
      maxLimit: json['maxLimit'] is int
          ? json['maxLimit']
          : int.tryParse(json['maxLimit']?.toString() ?? '') ?? 10,
      isSelect: (json['selected'] == '1' || json['selected'] == 1 ||
          json['selected'] == true) ? true : false,
      image: json['preview_url'] ?? "",
      count: int.tryParse(json['count']?.toString() ?? '1') ?? 1,
      id: json['id'] ?? "NA",
    );
  }


  /// Safe loop-based list parsing with error handling
  static List<CartModel> fromJsonList(List<dynamic>? list) {
    if (list == null) return [];

    List<CartModel> result = [];

    for (var item in list) {
      try {
        if (item is Map<String, dynamic>) {
          result.add(CartModel.fromJson(item));
        } else {
          // Optionally log this unexpected item type
          trace("Skipped");
        }
      } catch (e, stackTrace) {
        // Use your preferred logging method instead of trace if needed
        trace('Error parsing CartModel: $e\n$stackTrace');
        continue;
      }
    }

    return result;
  }


  /// Create a default initial model
  factory CartModel.initial() => CartModel(
    title: "title",
    brand: "brand",
    size: "L",
    price: 2300.0,
    maxLimit: 10,
    image: dummyImages[0],
    id: "test"
  );

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'brand': brand,
      'size': size,
      'price': price,
      'maxLimit': maxLimit,
      'isSelect': isSelect.value,
      'count': count.value,
      'image': image,
    };
  }
}
