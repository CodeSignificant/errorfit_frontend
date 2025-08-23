import 'dart:convert';

import '../../../resources/actions.dart';
import '../../../resources/data_response.dart';
import '../../api/api_sheet.dart';
import '../../api/secure_call.dart';

class ServicesRepo {
  static Future<DataResponse> raise({required String message}) async {
    try {
      final response = await SecureCall.post(
        Uri.parse(ApiSheet.services.raise),
        body: jsonEncode({"message": message}),
      );
      final res = jsonDecode(response.body);
      if (!(res['status'] ?? false)) {
        return DataFailed(res['message'] ?? "No response");
      }
      // final data = res['data'];
      return DataSuccess(res['message'] ?? "Support Raised");
    } catch (e) {
      trace(e.toString());
      return const DataFailed("Something went wrong");
    }
  }
}
