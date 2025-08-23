import 'package:error_fit/config/routes/routers.dart';
import 'package:error_fit/core/network/repo/users/notifications_repo.dart';
import 'package:error_fit/core/resources/data_response.dart';
import 'package:error_fit/core/widgets/loading_view.dart';
import 'package:error_fit/features/notifications/models/notifications_model.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  final loadingController = LoadingViewController();
  final notificationsList = <NotificationsModel>[].obs;

  @override
  void onInit() {
    _loadNotifications();
    super.onInit();
  }

  void _loadNotifications() async {
    loadingController.setLoading(true);
    final result = await NotificationsRepo.fetch();
    if (result is DataSuccess) {
      notificationsList.value = result.data!;
      if (notificationsList.isEmpty) {
        loadingController.setError("No Notifications you have");
        return;
      }
      loadingController.setLoading(false);
    }
    if (result is DataFailed) {
      loadingController.setError(result.error);
      return;
    }
  }

  onNotificationClick(NotificationsModel model) {
    model.isRead.value = true;
    navigate(model.route);
  }
}
