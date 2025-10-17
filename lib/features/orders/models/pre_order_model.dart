class PreOrderModel {
  final String title;
  final String brand;
  final String size;
  final int items;
  final int price;
  final int mrpPrice;
  final String previewUrl;

  PreOrderModel({
    required this.title,
    required this.brand,
    required this.size,
    required this.items,
    required this.price,
    required this.mrpPrice,
    required this.previewUrl,
  });

  factory PreOrderModel.fromJson(Map<String, dynamic> json) {
    return PreOrderModel(
      title: json['title'] ?? '',
      brand: json['brand'] ?? '',
      size: json['size'] ?? '',
      items: json['quantity'] is int
          ? json['quantity']
          : int.tryParse(json['quantity'].toString()) ?? 0,
      price: json['selling_price'] is int
          ? json['selling_price']
          : int.tryParse(json['selling_price'].toString()) ?? 0,
      mrpPrice: json['mrp_price'] is int
          ? json['mrp_price']
          : int.tryParse(json['mrp_price'].toString()) ?? 0,
      previewUrl: json['preview_url'] ?? '',
    );
  }




  static List<PreOrderModel> fromJsonList(dynamic jsonList) {
    List<PreOrderModel> list = [];
    try {
      if (jsonList is List) {
        for (var json in jsonList) {
          if (json is Map<String, dynamic>) {
            list.add(PreOrderModel.fromJson(json));
          }
        }
      }
    } catch (e) {
      print("Error parsing PreOrderModel list: $e");
    }
    return list;
  }
}
