import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../resources/actions.dart';
import '../../../resources/data_response.dart';
import '../../api/api_sheet.dart';

class PublicRepo {
  static Future<DataResponse> getHomeFlow() async {
    try {
      final response = await http.get(Uri.parse(ApiSheet.public.homeFlow));
      final res = jsonDecode(response.body);
      if (!(res['result']['status'] ?? false)) {
        return DataFailed(res['result']['message'] ?? "No response");
      }
      final data = res['data'];
      return DataSuccess(data);
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
