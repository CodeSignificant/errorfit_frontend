import 'package:error_fit/config/routes/routers.dart';
import 'package:error_fit/core/network/repo/orders/orders_repo.dart';
import 'package:error_fit/core/resources/data_response.dart';
import 'package:error_fit/core/resources/pagination.dart';
import 'package:error_fit/core/widgets/loading_view.dart';
import 'package:error_fit/features/orders/models/orders_model.dart';
import 'package:get/get.dart';

class OrdersController extends GetxController {
  final loadingControl = LoadingViewController();

  // final ordersList = <OrderModel>[].obs;
  final paginationControl = Pagination<OrderModel>();

  @override
  void onInit() {
    _loadOrders();
    super.onInit();
  }

  onOrderClick(OrderModel model) {
    orderDetailsRoute.param(model.id).navigate;
  }

  void _loadOrders() async {

    // final paginationControl = Pagination<OrderModel>();

    Pagination.listener(
      controller: paginationControl,
      onInitialLoad: () async {
        loadingControl.setLoading(true);
        final result = await OrdersRepo.fetch(page: 1);
        loadingControl.setLoading(false);
        if (result is DataSuccess) {
          return result.data;
        }
        return null;
      },
      onFetch: (nextPage) async {
        final result = await OrdersRepo.fetch(page: nextPage);
        if (result is DataSuccess) {
          return result.data;
        }
        return null;
      },
    );
  }
}
