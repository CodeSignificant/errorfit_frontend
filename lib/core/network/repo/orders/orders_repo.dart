import 'dart:convert';

import 'package:error_fit/features/orders/models/order_calculate_model.dart';
import 'package:error_fit/features/orders/models/orders_model.dart';

import '../../../resources/data_response.dart';
import '../../../resources/pagination.dart';
import '../../api/api_sheet.dart';
import '../../api/secure_call.dart';

class OrdersRepo {
  static Future<DataResponse<PaginationModel<OrderModel>>> fetch({
    required int page,
  }) async {
    return await SecureCall.tryGet(
      Uri.parse(ApiSheet.orders.fetch(page)),
      onSuccess: (response, res) async {
        return DataSuccess(
          PaginationModel(
            totalPages: int.tryParse(res['total_pages'].toString()) ?? 1,
            currentPage: int.tryParse(res['current_page'].toString()) ?? 1,
            items: OrderModel.fromJsonList(res['data'] ?? []),
          ),
        );
      },
    );
    // try {
    //   final response = await SecureCall.get(
    //     Uri.parse(ApiSheet.orders.fetch(page)),
    //   );
    //   final res = jsonDecode(response.body);
    //   if (!(res['status'] ?? false)) {
    //     return DataFailed(res['message'] ?? "No response");
    //   }
    //   // final data = res['data'];
    //   return DataSuccess(
    //     PaginationModel(
    //       totalPages: int.tryParse(res['total_pages'].toString()) ?? 1,
    //       currentPage: int.tryParse(res['present_page'].toString()) ?? 1,
    //       items: OrderModel.fromJsonList(res['data'] ?? []),
    //     ),
    //   );
    // } catch (e) {
    //   // trace(e.toString());
    //   return const DataFailed("Something went wrong");
    // }
  }

  static Future<DataResponse> createOrder({
    required String addressId,
    required String paymentMode,
    String? coupon
  }) async {
    return await SecureCall.tryPost(
      Uri.parse(ApiSheet.orders.createOrder),
      body: jsonEncode({
        "address_id": addressId,
        "payment_mode": paymentMode,
        "coupon": coupon ?? ""
      }),
      onSuccess: (response, res) async => DataSuccess(res??{}),
    );
    // try {
    //   final response = await SecureCall.post(
    //     Uri.parse(ApiSheet.orders.createOrder),
    //     body: jsonEncode({
    //       "address_id": addressId,
    //       "payment_mode": paymentMode,
    //       "coupon": coupon??""
    //     })
    //   );
    //   final res = jsonDecode(response.body);
    //   if (!(res['status'] ?? false)) {
    //     return DataFailed(res['message'] ?? "No response");
    //   }
    //   final data = res['data'];
    //   return DataSuccess(res);
    // } catch (e) {
    //   trace(e.toString());
    //   return const DataFailed("Something went wrong");
    // }
  }

  static Future<DataResponse<OrderCalculateModel>> calculateOrders({
    required String addressId,
    String? coupon
  }) async {
    return await SecureCall.tryPost(
      Uri.parse(ApiSheet.orders.calculateOrders),
      body: jsonEncode({
        "address_id": addressId,
        "coupon": coupon ?? ""
      }),
      onSuccess: (response, res) async =>
          DataSuccess(OrderCalculateModel.fromJson(res??{})),
    );
    // try {
    //   final response = await SecureCall.post(
    //     Uri.parse(ApiSheet.orders.calculateOrders),
    //     body: jsonEncode({
    //       "address_id": addressId,
    //       "coupon": coupon??""
    //     })
    //   );
    //   final res = jsonDecode(response.body);
    //   if (!(res['status'] ?? false)) {
    //     return DataFailed(res['message'] ?? "No response");
    //   }
    //   // final data = res['data'];
    //   return DataSuccess(OrderCalculateModel.fromJson(res));
    // } catch (e) {
    //   // trace(e.toString());
    //   return const DataFailed("Something went wrong");
    // }
  }

}
