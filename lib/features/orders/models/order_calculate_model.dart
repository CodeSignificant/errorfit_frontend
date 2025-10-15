import 'package:error_fit/core/resources/actions.dart';
import 'package:error_fit/features/orders/models/pre_order_model.dart';

class OrderCalculateModel {
  final int totalAmount;
  final int deliveryFee;
  final int couponDiscount;
  final int payableAmount;
  final int totalMrpAmount;
  final List<PreOrderModel> products;

  OrderCalculateModel({
    required this.totalAmount,
    required this.deliveryFee,
    required this.couponDiscount,
    required this.payableAmount,
    required this.totalMrpAmount,
    required this.products,
  });

  factory OrderCalculateModel.fromJson(Map<String, dynamic> json) {
      return OrderCalculateModel(
        totalAmount: json['total_amount'] ?? 0,
        deliveryFee: json['delivery_fee'] ?? 0,
        couponDiscount: json['coupon_discount'] ?? 0,
        payableAmount: json['payable_amount'] ?? 0,
        totalMrpAmount: json['total_mrp_price'] ?? 0,
        products: PreOrderModel.fromJsonList(json['products']),
      );
  }

  int get totalDiscount{
    return totalMrpAmount-totalAmount;
  }

  static List<OrderCalculateModel> fromJsonList(List<dynamic> jsonList) {
    List<OrderCalculateModel> list = [];
    for (var json in jsonList) {
      try {
        list.add(OrderCalculateModel.fromJson(json));
      } catch (e) {
        trace("Error parsing OrderCalculateModel list item: $e");
      }
    }
    return list;
  }
}
