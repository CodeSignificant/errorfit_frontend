import 'dart:convert';
import 'package:error_fit/core/network/api/secure_call.dart';
import 'package:error_fit/features/products/models/product_model.dart';
import 'package:http/http.dart' as http;
import '../../../resources/actions.dart';
import '../../../resources/data_response.dart';
import '../../api/api_sheet.dart';

class ViewsRepo {

  static Future<DataResponse<List<ProductModel>>> recentlyViewed() async {
    try {
      final response = await SecureCall.get(
        Uri.parse(ApiSheet.views.recentlyViewed)
      );
      final res = jsonDecode(response.body);
      if (!(res['status'] ?? false)) {
        return DataFailed(res['message'] ?? "No response");
      }
      return DataSuccess(ProductModel.fromJsonList(res['data'] ?? []));
    } catch (e) {
      trace(e.toString());
      return const DataFailed("Something went wrong");
    }
  }

}
