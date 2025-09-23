import 'dart:convert';

import 'package:error_fit/core/resources/pagination_model.dart';
import 'package:error_fit/features/orders/models/orders_model.dart';

import '../../../resources/actions.dart';
import '../../../resources/data_response.dart';
import '../../api/api_sheet.dart';
import '../../api/secure_call.dart';

class OrdersRepo {
  static Future<DataResponse<PaginationModel<List<OrderModel>>>> fetch({
    required int page,
  }) async {
    try {
      final response = await SecureCall.get(
        Uri.parse(ApiSheet.orders.fetch(page)),
      );
      final res = jsonDecode(response.body);
      if (!(res['status'] ?? false)) {
        return DataFailed(res['message'] ?? "No response");
      }
      // final data = res['data'];
      return DataSuccess(
        PaginationModel(
          data: OrderModel.fromJsonList(res['data'] ?? []),
          presentPage: res['present_page'] is int
              ? res['present_page']
              : int.tryParse(res['present_page']?.toString() ?? '') ?? 1,

          totalPages: res['total_pages'] is int
              ? res['total_pages']
              : int.tryParse(res['total_pages']?.toString() ?? '') ?? 1,

        ),
      );
    } catch (e) {
      trace(e.toString());
      return const DataFailed("Something went wrong");
    }
  }

  static Future<DataResponse> createOrder({
    required String addressId,
    required String paymentMode,
    String? coupon
  }) async {
    try {
      final response = await SecureCall.post(
        Uri.parse(ApiSheet.orders.createOrder),
        body: jsonEncode({
          "address_id": addressId,
          "payment_mode": paymentMode,
          "coupon": coupon??""
        })
      );
      final res = jsonDecode(response.body);
      if (!(res['status'] ?? false)) {
        return DataFailed(res['message'] ?? "No response");
      }
      final data = res['data'];
      return DataSuccess(res);
    } catch (e) {
      trace(e.toString());
      return const DataFailed("Something went wrong");
    }
  }
}
