import 'dart:convert';

import 'package:error_fit/config/services/auth.dart';
import 'package:http/http.dart' as http;

import '../../../resources/actions.dart';
import '../../../resources/data_response.dart';
import '../../api/api_sheet.dart';

class AuthRepo {
  static Future<DataResponse> mailOTPLogin({required String mail}) async {
    try {
      final response = await http.post(
        Uri.parse(ApiSheet.auth.mailOTP),
        body: jsonEncode({"mail": mail}),
      );
      final res = jsonDecode(response.body);
      trace(response.body.toString());
      if (!(res['status'] ?? false)) {
        trace(response.body);
        return DataFailed(res['message'] ?? "No response");
      }
      final data = res['token'];
      return DataSuccess(data);
    } catch (e) {
      trace(e.toString());
      return const DataFailed("Something went wrong");
    }
  }

  static Future<DataResponse> phoneOTPLogin({required String phone}) async {
    try {
      final response = await http.post(
        Uri.parse(ApiSheet.auth.phoneOTP),
        body: jsonEncode({"phone": phone, "country_code": "+91"}),
      );
      final res = jsonDecode(response.body);
      trace(response.body.toString());
      if (!(res['status'] ?? false)) {
        trace(response.body);
        return DataFailed(res['message'] ?? "No response");
      }
      final data = res['token'];
      return DataSuccess(data);
    } catch (e) {
      trace(e.toString());
      return const DataFailed("Something went wrong");
    }
  }

  static Future<DataResponse> verifyOTP({
    required String otp,
    required String token,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(ApiSheet.auth.verifyOTP),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"otp": otp, "device": await getUniqueDeviceName()}),
      );
      final res = jsonDecode(response.body);
      if (!(res['status'] ?? false)) {
        trace(response.body);
        return DataFailed(res['message'] ?? "No response");
      }
      Auth.setToken(res['token'] ?? "");
      return DataSuccess(res['message'] ?? "");
    } catch (e) {
      trace(e.toString());
      return const DataFailed("Something went wrong");
    }
  }

  // static Future<DataResponse> getUserDetails() async {
  //   try {
  //     final response = await SecureCall.get(
  //       Uri.parse(ApiSheet.common.userDetails),
  //     );
  //     final res = jsonDecode(response.body);
  //     if (res['status'] != "success") {
  //       return DataFailed(res['message'] ?? "No response");
  //     }
  //     final data = res['data'];
  //     Auth.setUser(
  //       fName: data['firstName'] ?? "name",
  //       lName: data['lastName'] ?? "",
  //       mail: data['email'] ?? "",
  //       name: data['username'] ?? "",
  //       phone: data['phoneNumber'] ?? "",
  //       referral: data['referralCode'] ?? "",
  //       roleName: data['roleName'] ?? "",
  //       rollId: data['roleId'] ?? 0,
  //     );
  //     return DataSuccess(res['message']);
  //   } catch (e) {
  //     trace(e.toString());
  //     return const DataFailed("Something went wrong");
  //   }
  // }
}
