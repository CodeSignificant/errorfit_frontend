import '../../../core/resources/actions.dart'; // For trace logging if needed

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

/// Model representing an order with tracking details
class OrderModel {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String authId;
  final String productId;
  final String addressId;
  final String paymentId;
  final String trackingId;
  final String merchantId;
  final String title;
  final String previewUrl;
  final int price;
  final int quantity;

  /// Observable properties for UI reactive updates
  final String status;
  final DateTime statusDate;
  final List<TrackingStatus> trackingJson;

  OrderModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.authId,
    required this.productId,
    required this.addressId,
    required this.paymentId,
    required this.trackingId,
    required this.merchantId,
    required this.title,
    required this.previewUrl,
    required this.price,
    required this.quantity,
    required this.status,
    required this.statusDate,
    required this.trackingJson,
  });

  /// Create an OrderModel instance from JSON map
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? '',
      createdAt:
          DateTime.tryParse(json['created_at']?.toString() ?? '') ??
          DateTime.now(),
      updatedAt:
          DateTime.tryParse(json['updated_at']?.toString() ?? '') ??
          DateTime.now(),
      authId: json['auth_id'] ?? '',
      productId: json['product_id'] ?? '',
      addressId: json['address_id'] ?? '',
      paymentId: json['payment_id'] ?? '',
      trackingId: json['tracking_id'] ?? '',
      merchantId: json['merchant_id'] ?? '',
      title: json['title'] ?? '',
      previewUrl: json['preview_url'] ?? '',
      price: int.tryParse(json['price']?.toString() ?? '0') ?? 0,
      quantity: int.tryParse(json['quantity']?.toString() ?? '0') ?? 1,
      status: json['status'] ?? "Pending",
      statusDate:
          DateTime.tryParse(json['status_date']?.toString() ?? '') ??
          DateTime.now(),
      trackingJson: TrackingStatus.fromJsonList(json['tracking_json'] ?? []),
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
    id: "test_order",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    authId: "auth_1",
    productId: "prod_1",
    addressId: "addr_1",
    paymentId: "pay_1",
    trackingId: "track_1",
    merchantId: "merch_1",
    title: "Sample Product",
    previewUrl: "https://placehold.co/200x200",
    price: 100,
    quantity: 1,
    status: "New",
    statusDate: DateTime.now(),
    trackingJson: [TrackingStatus(status: "New", date: DateTime.now())],
  );

  /// Convert OrderModel instance to JSON map
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
      "auth_id": authId,
      "product_id": productId,
      "address_id": addressId,
      "payment_id": paymentId,
      "tracking_id": trackingId,
      "merchant_id": merchantId,
      "title": title,
      "preview_url": previewUrl,
      "price": price,
      "quantity": quantity,
      "status": status,
      "status_date": statusDate.toIso8601String(),
      "tracking_json": trackingJson.map((e) => e.toJson()).toList(),
    };
  }
}
