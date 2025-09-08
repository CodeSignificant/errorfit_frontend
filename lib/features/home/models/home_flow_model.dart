abstract class HomeFlowModel {}

class HorizontalImagesFlowModel extends HomeFlowModel {
  final String title;
  final String image;
  final String route;

  HorizontalImagesFlowModel({
    required this.title,
    required this.image,
    required this.route,
  });

  // Factory constructor to create instance from JSON
  factory HorizontalImagesFlowModel.fromJson(Map<String, dynamic> json) {
    return HorizontalImagesFlowModel(
      title: json['title'] as String? ?? '',
      image: json['image'] as String? ?? '',
      route: json['route'] as String? ?? '',
    );
  }

  // Convert list of JSON maps to list of CategoryFlowModel
  static List<HorizontalImagesFlowModel> fromJsonList(List<dynamic> list) {
    final List<HorizontalImagesFlowModel> items = [];

    for (var json in list) {
      try {
        items.add(HorizontalImagesFlowModel.fromJson(json));
      } catch (e) {
        continue;
      }
    }

    return items;
  }

  // Optional: toJson method for serialization
  Map<String, dynamic> toJson() {
    return {'title': title, 'image': image, 'route': route};
  }
}

class CategoryFlowModel extends HomeFlowModel {
  final String title;
  final String image;
  final String route;

  CategoryFlowModel({
    required this.title,
    required this.image,
    required this.route,
  });

  // Factory constructor to create instance from JSON
  factory CategoryFlowModel.fromJson(Map<String, dynamic> json) {
    return CategoryFlowModel(
      title: json['title'] as String? ?? '',
      image: json['image'] as String? ?? '',
      route: json['route'] as String? ?? '',
    );
  }

  // Convert list of JSON maps to list of CategoryFlowModel
  static List<CategoryFlowModel> fromJsonList(List<dynamic> list) {
    final List<CategoryFlowModel> items = [];

    for (var json in list) {
      try {
        items.add(CategoryFlowModel.fromJson(json));
      } catch (e) {
        continue;
      }
    }

    return items;
  }

  // Optional: toJson method for serialization
  Map<String, dynamic> toJson() {
    return {'title': title, 'image': image, 'route': route};
  }
}

class AdImageFlowModel extends HomeFlowModel {
  final String image;
  final String route;

  AdImageFlowModel({required this.image, required this.route});

  factory AdImageFlowModel.fromJson(Map<String, dynamic> json) {
    return AdImageFlowModel(
      image: json['image'] ?? "",
      route: json['route'] ?? "",
    );
  }
}

class Grid3FlowModel extends HomeFlowModel {
  final String title;
  final String image;
  final String route;

  Grid3FlowModel({
    required this.title,
    required this.image,
    required this.route,
  });

  // Factory constructor to create instance from JSON
  factory Grid3FlowModel.fromJson(Map<String, dynamic> json) {
    return Grid3FlowModel(
      title: json['title'] as String? ?? '',
      image: json['image'] as String? ?? '',
      route: json['route'] as String? ?? '',
    );
  }

  // Convert list of JSON maps to list of CategoryFlowModel
  static List<Grid3FlowModel> fromJsonList(List<dynamic> list) {
    final List<Grid3FlowModel> items = [];

    for (var json in list) {
      try {
        items.add(Grid3FlowModel.fromJson(json));
      } catch (e) {
        // Skip this item if parsing fails
        continue;
      }
    }

    return items;
  }

  // Optional: toJson method for serialization
  Map<String, dynamic> toJson() {
    return {'title': title, 'image': image, 'route': route};
  }
}

class Grid2FlowModel extends HomeFlowModel {
  final String title;
  final String image;
  final String route;

  Grid2FlowModel({
    required this.title,
    required this.image,
    required this.route,
  });

  // Factory constructor to create instance from JSON
  factory Grid2FlowModel.fromJson(Map<String, dynamic> json) {
    return Grid2FlowModel(
      title: json['title'] as String? ?? '',
      image: json['image'] as String? ?? '',
      route: json['route'] as String? ?? '',
    );
  }

  // Convert list of JSON maps to list of CategoryFlowModel
  static List<Grid2FlowModel> fromJsonList(List<dynamic> list) {
    final List<Grid2FlowModel> items = [];

    for (var json in list) {
      try {
        items.add(Grid2FlowModel.fromJson(json));
      } catch (e) {
        // Skip this item if parsing fails
        continue;
      }
    }

    return items;
  }

  // Optional: toJson method for serialization
  Map<String, dynamic> toJson() {
    return {'title': title, 'image': image, 'route': route};
  }
}
