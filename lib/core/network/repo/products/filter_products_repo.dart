import 'dart:convert';

import 'package:error_fit/core/network/api/secure_call.dart';
import 'package:error_fit/core/resources/pagination.dart';
import 'package:error_fit/features/products/models/product_details_model.dart';
import 'package:error_fit/features/products/models/product_model.dart';

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
  static Future<DataResponse<List<ProductModel>>> search({required String search}) async {
    return await SecureCall.tryPost(
      Uri.parse(ApiSheet.products.search),
      body: jsonEncode({'search': search}),
      onSuccess: (response, data) async {
        final list = data['data'] ?? [];
        return DataSuccess(ProductModel.fromJsonList(list));
      },
    );
  }


  static Future<DataResponse<ProductDetailsModel>> details(
      {required String id}) async {
    return await SecureCall.tryPost(
      Uri.parse(ApiSheet.products.details),
      body: jsonEncode({"id": id}),
      onSuccess: (response, res) async =>
          DataSuccess(ProductDetailsModel.fromJson(res['data'] ?? [])),
    );
  }

  static Future<DataResponse> filterJson() async {
    return await SecureCall.tryGet(
      Uri.parse(ApiSheet.products.filterJson),
      onSuccess: (response, res) async => DataSuccess(res['data'] ?? []),
    );
  }

  static Future<DataResponse<PaginationModel<ProductModel>>> searchProducts(
      {required String search, required dynamic filters, required int page}) async {
    return await SecureCall.tryPost(
      Uri.parse(ApiSheet.products.searchFilter),
      headers: {},
      body: jsonEncode({"search": search, "filter": filters}),
      onSuccess: (response, res) async {
        return DataSuccess(PaginationModel(
            totalPages: int.tryParse(res['total_pages'].toString()) ?? 1,
            currentPage: int.tryParse(res['current_page'].toString()) ?? 1,
            items: ProductModel.fromJsonList(res['data'] ?? [])
        ));
      },);
  }
}
