import 'package:error_fit/features/products/models/product_model.dart';

class ProductDetailsModel {
  final String productId;
  final String title;
  final String description;
  final String mrpPrice;
  final String sellingPrice;
  final bool isLiked;
  final ProductInfo info;
  final Seller seller;
  final List<String> images;
  final List<Variant> variants;
  final List<SizeOption> sizes;
  final List<ProductModel> similar;

  ProductDetailsModel({
    required this.productId,
    required this.title,
    required this.description,
    required this.mrpPrice,
    required this.sellingPrice,
    required this.isLiked,
    required this.info,
    required this.seller,
    required this.images,
    required this.variants,
    required this.sizes,
    required this.similar,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      productId: json['product_id'] ?? "NA",
      title: json['title'] ?? "NA",
      description: json['description'] ?? "NA",
      mrpPrice: json['mrp_price'] ?? "0",
      sellingPrice: json['selling_price'] ?? "0",
      isLiked: json['is_liked'] is bool
          ? json['is_liked']
          : (json['is_liked'] == '1' || json['is_liked'] == 1),
      info: ProductInfo.fromJson(json['info'] ?? {}),
      seller: Seller.fromJson(json['seller'] ?? {}),
      images: json['images'] != null ? List<String>.from(json['images']) : [],
      variants: Variant.fromJsonList(json['variants']),
      sizes: SizeOption.fromJsonList(json['sizes']),
      similar:ProductModel.fromJsonList(json['similar']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'title': title,
      'description': description,
      'mrp_price': mrpPrice,
      'selling_price': sellingPrice,
      'is_liked': isLiked,
      'info': info.toJson(),
      'seller': seller.toJson(),
      'images': images,
      'variants': variants.map((v) => v.toJson()).toList(),
      'sizes': sizes.map((s) => s.toJson()).toList(),
      'similar': similar.map((s) => s.toJson()).toList(),
    };
  }

  static ProductDetailsModel initial() {
    return ProductDetailsModel(
      productId: "NA",
      title: "NA",
      description: "NA",
      mrpPrice: "0",
      sellingPrice: "0",
      isLiked: false,
      info: ProductInfo.initial(),
      seller: Seller.initial(),
      images: [],
      variants: [],
      sizes: [],
      similar: [],
    );
  }
}

class ProductInfo {
  final List<InfoDetail> details;
  final String info;

  ProductInfo({required this.details, required this.info});

  factory ProductInfo.fromJson(Map<String, dynamic> json) {
    return ProductInfo(
      details: InfoDetail.fromJsonList(json['details']),
      info: json['info'] ?? "NA",
    );
  }

  Map<String, dynamic> toJson() {
    final detailsJson = <Map<String, dynamic>>[];
    for (var d in details) {
      detailsJson.add(d.toJson());
    }
    return {'details': detailsJson, 'info': info};
  }

  static List<ProductInfo> fromJsonList(List<dynamic>? jsonList) {
    List<ProductInfo> list = [];
    if (jsonList != null) {
      for (var json in jsonList) {
        list.add(ProductInfo.fromJson(json));
      }
    }
    return list;
  }

  static ProductInfo initial() {
    return ProductInfo(details: [], info: "NA");
  }
}

class InfoDetail {
  final String title;
  final String value;

  InfoDetail({required this.title, required this.value});

  factory InfoDetail.fromJson(Map<String, dynamic> json) {
    return InfoDetail(
      title: json['title'] ?? "NA",
      value: json['value'] ?? "NA",
    );
  }

  Map<String, dynamic> toJson() => {'title': title, 'value': value};

  static List<InfoDetail> fromJsonList(List<dynamic>? jsonList) {
    List<InfoDetail> list = [];
    if (jsonList != null) {
      for (var json in jsonList) {
        list.add(InfoDetail.fromJson(json));
      }
    }
    return list;
  }

  static InfoDetail initial() {
    return InfoDetail(title: "NA", value: "NA");
  }
}

class Seller {
  final String createdAt;
  final String name;
  final String address;
  final String logoUrl;

  Seller({
    required this.createdAt,
    required this.name,
    required this.address,
    required this.logoUrl,
  });

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
      createdAt: json['created_at'] ?? "NA",
      name: json['name'] ?? "NA",
      address: json['address'] ?? "NA",
      logoUrl: json['logo_url'] ?? "NA",
    );
  }

  Map<String, dynamic> toJson() => {
    'created_at': createdAt,
    'name': name,
    'address': address,
    'logo_url': logoUrl,
  };

  static List<Seller> fromJsonList(List<dynamic>? jsonList) {
    List<Seller> list = [];
    if (jsonList != null) {
      for (var json in jsonList) {
        list.add(Seller.fromJson(json));
      }
    }
    return list;
  }

  static Seller initial() {
    return Seller(createdAt: "NA", name: "NA", address: "NA", logoUrl: "NA");
  }
}

class Variant {
  final String previewUrl;
  final String id;

  Variant({required this.previewUrl, required this.id});

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      previewUrl: json['preview_url'] ?? "NA",
      id: json['id'] ?? "NA",
    );
  }

  Map<String, dynamic> toJson() => {'preview_url': previewUrl, 'id': id};

  static List<Variant> fromJsonList(List<dynamic>? jsonList) {
    List<Variant> list = [];
    if (jsonList != null) {
      for (var json in jsonList) {
        list.add(Variant.fromJson(json));
      }
    }
    return list;
  }

  static Variant initial() {
    return Variant(previewUrl: "NA", id: "NA");
  }
}

class SizeOption {
  final String size;
  final String id;

  SizeOption({required this.size, required this.id});

  factory SizeOption.fromJson(Map<String, dynamic> json) {
    return SizeOption(
      size: json['size'] ?? json['sizze'] ?? "NA",
      id: json['id'] ?? "NA",
    );
  }

  Map<String, dynamic> toJson() => {'size': size, 'id': id};

  static List<SizeOption> fromJsonList(List<dynamic>? jsonList) {
    List<SizeOption> list = [];
    if (jsonList != null) {
      for (var json in jsonList) {
        list.add(SizeOption.fromJson(json));
      }
    }
    return list;
  }

  static SizeOption initial() {
    return SizeOption(size: "NA", id: "NA");
  }
}

// class SimilarProduct {
//   final String id;
//   final String title;
//   final String brand;
//   final String mrpPrice;
//   final String sellingPrice;
//   final String previewUrl;
//   final bool isLiked;
//
//   SimilarProduct({
//     required this.id,
//     required this.title,
//     required this.brand,
//     required this.mrpPrice,
//     required this.sellingPrice,
//     required this.previewUrl,
//     required this.isLiked,
//   });
//
//   factory SimilarProduct.fromJson(Map<String, dynamic> json) {
//     return SimilarProduct(
//       id: json['id'] ?? "NA",
//       title: json['title'] ?? "NA",
//       brand: json['brand'] ?? "NA",
//       mrpPrice: json['mrp_price'] ?? "0",
//       sellingPrice: json['selling_price'] ?? "0",
//       previewUrl: json['preview_url'] ?? "NA",
//       isLiked: json['is_liked'] == "1" || json['is_liked'] == 1 ? true : false,
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'title': title,
//     'brand': brand,
//     'mrp_price': mrpPrice,
//     'selling_price': sellingPrice,
//     'preview_url': previewUrl,
//     'is_liked': isLiked,
//   };
//
//   static List<SimilarProduct> fromJsonList(List<dynamic>? jsonList) {
//     List<SimilarProduct> list = [];
//     if (jsonList != null) {
//       for (var json in jsonList) {
//         list.add(SimilarProduct.fromJson(json));
//       }
//     }
//     return list;
//   }
//
//   static SimilarProduct initial() {
//     return SimilarProduct(
//       id: "NA",
//       title: "NA",
//       brand: "NA",
//       mrpPrice: "0",
//       sellingPrice: "0",
//       previewUrl: "NA",
//       isLiked: false,
//     );
//   }
// }
