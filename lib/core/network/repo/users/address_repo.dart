import 'dart:convert';

import 'package:error_fit/features/address/models/address_model.dart';

import '../../../resources/actions.dart';
import '../../../resources/data_response.dart';
import '../../api/api_sheet.dart';
import '../../api/secure_call.dart';

class AddressRepo {
  static Future<DataResponse> addNew({
    required String name,
    required String mail,
    required String phone,
    required String countryCode,
    required String pincode,
    required String address,
    double? lat,
    double? lon,
    required bool makeDefault
  }) async {
    try {
      final response = await SecureCall.post(
        Uri.parse(ApiSheet.address.addNew),
        body: jsonEncode({
          "name": name,
          "mail": mail,
          "phone": phone,
          "country_code": countryCode,
          "pincode": pincode,
          "address": address,
          "lat": lat,
          "lon": lon,
          "make_default": makeDefault ? 1 : 0
        }),
      );
      final res = jsonDecode(response.body);
      trace(response.body.toString());
      if (!(res['status'] ?? false)) {
        trace(response.body);
        return DataFailed(res['message'] ?? "No response");
      }
      // final data = res['data'];
      return DataSuccess(res['id'] ?? "");
    } catch (e) {
      trace(e.toString());
      return const DataFailed("Something went wrong");
    }
  }

  static Future<DataResponse> update({
    required String id,
    required String name,
    required String mail,
    required String phone,
    required String countryCode,
    required String pincode,
    required String address,
    required bool isPrimary,
    double? lat,
    double? lon,
  }) async {
    try {
      final response = await SecureCall.post(
        Uri.parse(ApiSheet.address.update),
        body: jsonEncode({
          "id": id,
          "name": name,
          "mail": mail,
          "phone": phone,
          "country_code": countryCode,
          "pincode": pincode,
          "address": address,
          "lat": lat,
          "lon": lon,
          "make_default": isPrimary ? 1 : 0
        }),
      );
      final res = jsonDecode(response.body);
      trace(response.body.toString());
      if (!(res['status'] ?? false)) {
        trace(response.body);
        return DataFailed(res['message'] ?? "No response");
      }
      // final data = res['data'];
      return DataSuccess(res['message'] ?? "Added");
    } catch (e) {
      trace(e.toString());
      return const DataFailed("Something went wrong");
    }
  }

  static Future<DataResponse> delete({
    required String id,
  }) async {
    try {
      final response = await SecureCall.post(
        Uri.parse(ApiSheet.address.delete),
        body: jsonEncode({"id": id}),
      );
      final res = jsonDecode(response.body);
      if (!(res['status'] ?? false)) {
        trace(response.body);
        return DataFailed(res['message'] ?? "No response");
      }
      // final data = res['data'];
      return DataSuccess(res['data'] ?? "Deleted Successfully");
    } catch (e) {
      trace(e.toString());
      return const DataFailed("Something went wrong");
    }
  }

  static Future<DataResponse<List<AddressModel>>> fetch() async {
    try {
      final response = await SecureCall.get(Uri.parse(ApiSheet.address.fetch));
      final res = jsonDecode(response.body);
      if (!(res['status'] ?? false)) {
        trace(response.body);
        return DataFailed(res['message'] ?? "No response");
      }
      // final data = res['data'];
      return DataSuccess(AddressModel.fromJsonList(res['data'] ?? []));
    } catch (e) {
      trace(e.toString());
      return const DataFailed("Something went wrong");
    }
  }

  static Future<DataResponse<AddressModel>> fetchDefault() async {
    try {
      final response = await SecureCall.get(
          Uri.parse(ApiSheet.address.fetchDefault));
      final res = jsonDecode(response.body);
      if (!(res['status'] ?? false)) {
        trace(response.body);
        return DataFailed(res['message'] ?? "No response");
      }
      // final data = res['data'];
      return DataSuccess(AddressModel.fromJson(res['data'] ?? []));
    } catch (e) {
      trace(e.toString());
      return const DataFailed("Something went wrong");
    }
  }

  static Future<DataResponse> updateDefault({required String id}) async {
    try {
      final response = await SecureCall.post(
          Uri.parse(ApiSheet.address.updateDefault),
          body: jsonEncode({
            "id": id
          }));
      final res = jsonDecode(response.body);
      if (!(res['status'] ?? false)) {
        trace(response.body);
        return DataFailed(res['message'] ?? "No response");
      }
      // final data = res['data'];
      return DataSuccess(res['message']);
    } catch (e) {
      trace(e.toString());
      return const DataFailed("Something went wrong");
    }
  }
}
