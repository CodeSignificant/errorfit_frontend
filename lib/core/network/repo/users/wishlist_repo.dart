import 'dart:convert';

import 'package:error_fit/core/network/api/secure_call.dart';
import 'package:error_fit/core/resources/pagination.dart';
import 'package:error_fit/features/products/models/product_model.dart';

import '../../../resources/actions.dart';
import '../../../resources/data_response.dart';
import '../../api/api_sheet.dart';

class WishlistRepo {

  static Future<DataResponse> setLike({required String productId, required bool like}) async {
    try {
      final response = await SecureCall.post(
        Uri.parse(ApiSheet.wishlist.addNew),
        body: jsonEncode({"product_id": productId, "status":like?1:0}),
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

  static Future<DataResponse<PaginationModel<ProductModel>>> fetch(
      {int page = 1}) async {
    return await SecureCall.tryGet(
      Uri.parse(ApiSheet.wishlist.fetch(page)),
      onSuccess: (response, res) async {
        return DataSuccess(
          PaginationModel(
            totalPages: int.tryParse(res['total_pages'].toString()) ?? 1,
            currentPage: int.tryParse(res['current_page'].toString()) ?? 1,
            items: ProductModel.fromJsonList(res['data'] ?? [], isLiked: true),
          ),
      );
      },);
    // try {
    //   final response = await SecureCall.get(
    //     Uri.parse(ApiSheet.wishlist.fetch),
    //   );
    //   final res = jsonDecode(response.body);
    //   if (!(res['status'] ?? false)) {
    //     trace(response.body);
    //     return DataFailed(res['message'] ?? "No response");
    //   }
    //   // final data = res['data'];
    //   return DataSuccess(ProductModel.fromJsonList(res['data'], isLiked: true));
    // } catch (e) {
    //   trace(e.toString());
    //   return const DataFailed("Something went wrong");
    // }
  }
}