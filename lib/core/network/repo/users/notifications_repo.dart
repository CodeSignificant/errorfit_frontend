import 'dart:convert';

import 'package:error_fit/core/network/api/secure_call.dart';
import 'package:error_fit/features/notifications/models/notifications_model.dart';

import '../../../resources/actions.dart';
import '../../../resources/data_response.dart';
import '../../api/api_sheet.dart';

class NotificationsRepo {


  static Future<DataResponse<List<NotificationsModel>>> fetch() async {
    try {
      final response = await SecureCall.get(
        Uri.parse(ApiSheet.notifications.fetch),
      );
      final res = jsonDecode(response.body);
      if (!(res['status'] ?? false)) {
        return DataFailed(res['message'] ?? "No response");
      }
      // final data = res['data'];
      return DataSuccess(NotificationsModel.fromJsonList(res['data']));
    } catch (e) {
      trace(e.toString());
      return const DataFailed("Something went wrong");
    }
  }
}