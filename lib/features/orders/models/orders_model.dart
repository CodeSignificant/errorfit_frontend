import '../../../../core/resources/actions.dart'; // For trace logging if needed

/// Model representing the tracking status of an order
class TrackingStatus {
  final String status;
  final DateTime date;

  TrackingStatus({required this.status, required this.date});

  /// Create a TrackingStatus instance from JSON map
  factory TrackingStatus.fromJson(Map<String, dynamic> json) {
    return TrackingStatus(
      status: json['status'] ?? '',
      date: DateTime.tryParse(json['date']?.toString() ?? '') ?? DateTime.now(),
    );
  }

  /// Safely parse a JSON list into a list of TrackingStatus instances
  static List<TrackingStatus> fromJsonList(List<dynamic>? list) {
    if (list == null) return [];

    List<TrackingStatus> result = [];
    for (var item in list) {
      try {
        if (item is Map<String, dynamic>) {
          result.add(TrackingStatus.fromJson(item));
        } else {
          trace("Skipped invalid item in TrackingStatus.fromJsonList");
        }
      } catch (e, stackTrace) {
        trace('Error parsing TrackingStatus: $e\n$stackTrace');
        continue;
      }
    }
    return result;
  }

  /// Convert instance to JSON map
  Map<String, dynamic> toJson() {
    return {'status': status, 'date': date.toIso8601String()};
  }
}

class OrderModel {
  final String id;
  final String title;
  final String previewUrl;
  final int quantity;

  /// Observable properties for UI reactive updates
  final String status;
  // final DateTime statusDate;
  // final List<TrackingStatus> trackingJson;

  OrderModel({
    required this.id,
    required this.title,
    required this.previewUrl,
    required this.quantity,
    required this.status
  });

  /// Create an OrderModel instance from JSON map
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      previewUrl: json['preview_url'] ?? '',
      quantity: int.tryParse(json['count']?.toString() ?? '0') ?? 1,
      status: json['status'] ?? "Pending",
    );
  }

  /// Safely parse a JSON list into a list of OrderModel instances
  static List<OrderModel> fromJsonList(List<dynamic>? list) {
    if (list == null) return [];

    List<OrderModel> result = [];
    for (var item in list) {
      try {
        if (item is Map<String, dynamic>) {
          result.add(OrderModel.fromJson(item));
        } else {
          trace("Skipped invalid item in OrderModel.fromJsonList");
        }
      } catch (e, stackTrace) {
        trace('Error parsing OrderModel: $e\n$stackTrace');
        continue;
      }
    }
    return result;
  }

  /// Create a default initial OrderModel for testing or placeholder use
  factory OrderModel.initial() => OrderModel(
    id: "",
    title: "",
    previewUrl: "",
    quantity: 1,
    status: "New",
  );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "preview_url": previewUrl,
      "quantity": quantity,
      "status": status
    };
  }
}
