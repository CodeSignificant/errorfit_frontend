import 'dart:convert';

import '../../../resources/actions.dart';
import '../../../resources/data_response.dart';
import '../../api/api_sheet.dart';
import '../../api/secure_call.dart';

class PaymentsRepo {


  static Future<DataResponse> cartOrder() async {
    try {
      final response = await SecureCall.post(
          Uri.parse(ApiSheet.payments.cartOrder));
      if(response.statusCode != 200){
        return DataFailed("Server Error: ${response.statusCode}");
      }
      final res = jsonDecode(response.body);
      if (!(res['status'] ?? false)) {
        trace(response.body);
        return DataFailed(res['message'] ?? "No response");
      }
      return DataSuccess(res['order_id'] ?? "");
    } catch (e) {
      trace(e.toString());
      return const DataFailed("Something went wrong");
    }
  }
}