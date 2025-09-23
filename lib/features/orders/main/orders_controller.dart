import 'package:error_fit/core/network/repo/orders/orders_repo.dart';
import 'package:error_fit/core/resources/data_response.dart';
import 'package:error_fit/core/widgets/loading_view.dart';
import 'package:error_fit/features/orders/models/orders_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OrdersController extends GetxController {
  final loadingControl = LoadingViewController();
  final scrollControl = ScrollController();
  final ordersList = <OrderModel>[].obs;
  int presentPage = 1;
  int totalPages = 10;

  @override
  void onInit() {
    scrollControl.addListener(() {
      if (scrollControl.position.pixels ==
          scrollControl.position.maxScrollExtent) {
        if (totalPages > presentPage) _fetchOrders(page: ++presentPage);
      }
    });
    _loadOrders();
    super.onInit();
  }

  onOrderClick(OrderModel model) {}

  void _loadOrders() async {
    final result = await OrdersRepo.fetch(page: 1);
    if (result is DataSuccess) {
      presentPage = result.data!.presentPage;
      totalPages = result.data!.totalPages;
      ordersList.value = result.data!.data;
      if (ordersList.isEmpty) {
        loadingControl.setError("No Orders Placed");
        return;
      }
      loadingControl.setLoading(false);
    }
    if (result is DataFailed) {
      loadingControl.setError(result.error);
      return;
    }
  }

  void _fetchOrders({int page = 2}) async {
    final result = await OrdersRepo.fetch(page: page);
    if (result is DataSuccess) {
      presentPage = result.data!.presentPage;
      totalPages = result.data!.totalPages;
      ordersList.addAll(result.data!.data);
    }
  }
}
