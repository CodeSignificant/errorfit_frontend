import 'package:error_fit/core/resources/constants.dart';
import 'package:get/get.dart';

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
      price: json['price'] is double
          ? json['price']
          : double.tryParse(json['price']?.toString() ?? '') ?? 0.0,
      maxLimit: json['maxLimit'] is int
          ? json['maxLimit']
          : int.tryParse(json['maxLimit']?.toString() ?? '') ?? 10,
      isSelect: json['isSelect'] ?? false,
      image: json['image'] ?? "",
      count: json['count'] ?? 1,
      id: json['id'] ?? "0",
    );
  }

  /// Safe loop-based list parsing with error handling
  static List<CartModel> fromJsonList(List<dynamic> list) {
    List<CartModel> result = [];

    for (var item in list) {
      try {
        if (item is Map<String, dynamic>) {
          result.add(CartModel.fromJson(item));
        }
      } catch (e) {
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
