import 'package:get/get.dart';

import '../../../core/resources/actions.dart';

class AddressModel {
  final String id;
  final String name;
  final String mail;
  final String phone;
  final String countryCode;
  final String pincode;
  final String address;
  double? lat;
  double? lon;
  final Rx<bool> isSelected;

  AddressModel({
    required this.id,
    required this.name,
    required this.mail,
    required this.phone,
    required this.countryCode,
    required this.pincode,
    required this.address,
    this.lat,
    this.lon,
    required this.isSelected,
  });

  /// Convert from JSON
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      mail: json['mail'] ?? '',
      phone: json['phone'] ?? '',
      countryCode: json['country_code'] ?? '',
      pincode: json['pincode'] ?? '',
      address: json['address'] ?? '',
      lat: (json['lat'] is int ? (json['lat'] as int).toDouble() : double.tryParse(json['lat'].toString())) ?? 0.0,
      lon: (json['lon'] is int ? (json['lon'] as int).toDouble() : double.tryParse(json['lon'].toString())) ?? 0.0,
      isSelected: Rx(json['make_default'] == "1" ? true : false),
    );
  }


  /// Safe loop-based list parsing with error handling
  static List<AddressModel> fromJsonList(List<dynamic>? list) {
    if (list == null) return [];

    List<AddressModel> result = [];

    for (var item in list) {
      try {
        if (item is Map<String, dynamic>) {
          result.add(AddressModel.fromJson(item));
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

  factory AddressModel.initial() => AddressModel(
    id: "",
    phone: "",
    countryCode: "",
    mail: "",
    address: "",
    name: "",
    pincode: "",
    lat: null,
    lon: null,
    isSelected: Rx(false),
  );

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'mail': mail,
      'phone': phone,
      'country_code': countryCode,
      'pincode': pincode,
      'address': address,
      'lat': lat,
      'lon': lon,
    };
  }
}
