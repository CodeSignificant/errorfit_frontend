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
    int parseInt(dynamic value) {
      if (value is int) return value;
      if (value is String) return int.tryParse(value) ?? 0;
      return 0;
    }

    return OrderCalculateModel(
      totalAmount: parseInt(json['total_selling_price']),
      deliveryFee: parseInt(json['delivery_fee']),
      couponDiscount: parseInt(json['coupon_discount']),
      payableAmount: parseInt(json['payable_amount']),
      totalMrpAmount: parseInt(json['total_mrp_price']),
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
