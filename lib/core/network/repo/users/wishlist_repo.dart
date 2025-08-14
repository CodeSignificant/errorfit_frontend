import 'dart:convert';

import 'package:error_fit/core/network/api/secure_call.dart';

import '../../../resources/actions.dart';
import '../../../resources/data_response.dart';
import '../../api/api_sheet.dart';

class WishlistRepo {


  static Future<DataResponse> filter() async {
    try {
      final response = await SecureCall.post(
        Uri.parse(ApiSheet.wishlist.addNew),
        body: jsonEncode({"page_no": 1}),
      );
      final res = jsonDecode(response.body);
      trace(response.body.toString());
      if (!(res['status'] ?? false)) {
        trace(response.body);
        return DataFailed(res['message'] ?? "No response");
      }
      // final data = res['data'];
      return DataSuccess(res['message']??"Liked");
    } catch (e) {
      trace(e.toString());
      return const DataFailed("Something went wrong");
    }
  }
}