import 'package:error_fit/core/resources/constants.dart';
import 'package:get/get.dart';

import '../../../core/resources/actions.dart';

class NotificationsModel {
  final String title;
  final String message;
  final String createdAt;
  final String image;
  final Rx<String> status;
  final Rx<bool> isRead;
  final String route;
  final String id;

  NotificationsModel({
    required this.title,
    required this.message,
    required this.createdAt,
    required this.image,
    required this.status,
    required this.isRead,
    required this.route,
    required this.id,
  });

  /// Convert from JSON
  factory NotificationsModel.fromJson(Map<String, dynamic> json) {
    return NotificationsModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      createdAt: json['created_at'] ?? '',
      image: json['image'] ?? "",
      route: json['route'] ?? "",
      status: Rx(json['status'] ?? ""),
      isRead: Rx(json['is_read'] ?? false),
    );
  }

  /// Safe loop-based list parsing with error handling
  static List<NotificationsModel> fromJsonList(List<dynamic>? list) {
    if (list == null) return [];

    List<NotificationsModel> result = [];

    for (var item in list) {
      try {
        if (item is Map<String, dynamic>) {
          result.add(NotificationsModel.fromJson(item));
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
  factory NotificationsModel.initial() => NotificationsModel(
    id: "test",
    title: "Title",
    message: "some random message of the notifications all the one of tha wish",
    createdAt: "2025-12-02",
    image: dummyImages[1],
    route: "",
    status: Rx("New"),
    isRead: Rx(false),
  );

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'created_at': createdAt,
      'status': status,
      'image': image,
      'route': route,
      'is_read': isRead,
    };
  }
}
