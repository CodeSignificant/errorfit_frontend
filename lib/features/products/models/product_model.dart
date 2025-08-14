import 'package:error_fit/config/extensions/string_extensions.dart';
import 'package:error_fit/core/resources/actions.dart';
import 'package:error_fit/core/resources/constants.dart';
import 'package:get/get.dart';

class ProductModel {
  final String title;
  final String brand;
  final String image;
  final double sellingPrice;
  final double mrpPrice;
  final RxBool isLiked;
  final String id;

  ProductModel({
    required this.title,
    required this.brand,
    required this.image,
    required this.sellingPrice,
    required this.mrpPrice,
    required bool isLiked,
    required this.id,
  }) : isLiked = RxBool(isLiked);

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      title: json['title'] ?? '',
      brand: json['brand'] ?? '',
      image: json['preview_url'] ?? '',
      sellingPrice: (json['selling_price'] is String)
          ? double.tryParse(json['selling_price']) ?? 0.0
          : (json['selling_price']?.toDouble() ?? 0.0),
      mrpPrice: (json['mrp_price'] is String)
          ? double.tryParse(json['mrp_price']) ?? 0.0
          : (json['mrp_price']?.toDouble() ?? 0.0),
      isLiked: json['is_liked'] ?? false,
      id: json['id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'brand': brand,
      'image': image,
      'sellingPrice': sellingPrice,
      'mrpPrice': mrpPrice,
      'isLiked': isLiked.value,
      'id': id,
    };
  }

  int get offer {
    if (sellingPrice == 0) return 0;
    return (((mrpPrice - sellingPrice) / mrpPrice) * 100).round();
  }

  static List<ProductModel> fromJsonList(List<dynamic> list) {
    final result = <ProductModel>[];
    for (var item in list) {
      try {
        result.add(ProductModel.fromJson(item));
      } catch (e) {
        trace(e.toString());
        continue;
      }
    }
    return result;
  }

  factory ProductModel.initial() {
    return ProductModel(
      title: 'Sample Title',
      brand: 'Sample Brand',
      image: dummyImages[1].autoUrl,
      sellingPrice: 0.0,
      mrpPrice: 0.0,
      isLiked: false,
      id: 'testing',
    );
  }
}
