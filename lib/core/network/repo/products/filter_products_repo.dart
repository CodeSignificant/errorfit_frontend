import 'dart:convert';

import 'package:error_fit/core/network/api/secure_call.dart';
import 'package:error_fit/features/products/models/product_details_model.dart';
import 'package:error_fit/features/products/models/product_model.dart';
import 'package:http/http.dart' as http;

import '../../../resources/actions.dart';
import '../../../resources/data_response.dart';
import '../../api/api_sheet.dart';

class FilterProductsRepo {
  static Future<DataResponse<List<ProductModel>>> filter() async {
    try {
      final response = await SecureCall.post(
        Uri.parse(ApiSheet.products.filter),
        body: jsonEncode({"page_no": 1}),
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

  static Future<DataResponse<List<ProductModel>>> search(
      {required String search}) async {
    try {
      final response = await http.post(
        Uri.parse(ApiSheet.products.search),
        body: jsonEncode({"search": search}),
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

  static Future<DataResponse<ProductDetailsModel>> details(
      {required String id}) async {
    try {
      final response = await SecureCall.post(
        Uri.parse(ApiSheet.products.details),
        body: jsonEncode({"id": id}),
      );
      final res = jsonDecode(response.body);
      if (!(res['status'] ?? false)) {
        return DataFailed(res['message'] ?? "No response");
      }
      return DataSuccess(ProductDetailsModel.fromJson(res['data'] ?? []));
    } catch (e) {
      trace(e.toString());
      return const DataFailed("Something went wrong");
    }
  }
}
