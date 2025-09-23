class BrandSearchModel {
  final String image;
  final String route;

  BrandSearchModel({required this.image, required this.route});

  factory BrandSearchModel.fromJson(Map<String, dynamic> json) {
    return BrandSearchModel(
      image: json['image'] ?? "",
      route: json['route'] ?? "",
    );
  }

  static List<BrandSearchModel> fromJsonList(List<dynamic> list) {
    final result = <BrandSearchModel>[];
    for (var item in list) {
      try {
        result.add(BrandSearchModel.fromJson(item));
      } catch (_) {
        continue;
      }
    }
    return result;
  }
}
