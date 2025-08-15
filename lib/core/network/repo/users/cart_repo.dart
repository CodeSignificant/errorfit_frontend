import 'dart:convert';

import 'package:error_fit/core/network/api/secure_call.dart';
import 'package:error_fit/features/cart/models/cart_model.dart';

import '../../../resources/actions.dart';
import '../../../resources/data_response.dart';
import '../../api/api_sheet.dart';

class CartRepo {
  static Future<DataResponse> fetch() async {
    try {
      final response = await SecureCall.get(
        Uri.parse(ApiSheet.cart.fetch),
        // body: jsonEncode({"page_no": 1}),
      );
      final res = jsonDecode(response.body);
      // trace(response.body.toString());
      if (!(res['status'] ?? false)) {
        trace(response.body);
        return DataFailed(res['message'] ?? "No response");
      }
      // final data = res['data'];
      return DataSuccess(CartModel.fromJsonList(res['data']??[]));
    } catch (e) {
      trace(e.toString());
      return const DataFailed("Something went wrong");
    }
  }
}
