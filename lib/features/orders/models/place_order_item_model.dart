import 'package:error_fit/core/resources/constants.dart';

import '../../../core/resources/actions.dart';

class PlaceOrderItemModel {
  final String title;
  final String brand;
  final String size;
  final double price;
  final String image;
  final int count;
  final String productId;
  final String id;

  PlaceOrderItemModel({
    required this.title,
    required this.brand,
    required this.size,
    required this.price,
    required this.image,
    required this.count,
    required this.productId,
    required this.id,
  });

  /// Convert from JSON
  factory PlaceOrderItemModel.fromJson(Map<String, dynamic> json) {
    return PlaceOrderItemModel(
      title: json['title'] ?? '',
      brand: json['brand'] ?? '',
      size: json['size'] ?? '',
      price: json['selling_price'] is double
          ? json['selling_price']
          : double.tryParse(json['selling_price']?.toString() ?? '') ?? 0.0,
      image: json['preview_url'] ?? "",
      count: int.tryParse(json['count']?.toString() ?? '1') ?? 1,
      productId: json['product_id'] ?? "NA",
      id: json['id'] ?? "NA",
    );
  }

  /// Safe loop-based list parsing with error handling
  static List<PlaceOrderItemModel> fromJsonList(List<dynamic>? list) {
    if (list == null) return [];

    List<PlaceOrderItemModel> result = [];

    for (var item in list) {
      try {
        if (item is Map<String, dynamic>) {
          result.add(PlaceOrderItemModel.fromJson(item));
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
  factory PlaceOrderItemModel.initial() => PlaceOrderItemModel(
    title: "title",
    brand: "brand",
    size: "L",
    price: 2300.0,
    image: dummyImages[0],
    productId: "",
    count: 0,
    id: "",
  );

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'brand': brand,
      'size': size,
      'price': price,
      'image': image,
    };
  }
}
