import 'package:error_fit/core/app_bars/toast.dart';
import 'package:error_fit/core/network/repo/services/services_repo.dart';
import 'package:error_fit/core/resources/data_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SupportController extends GetxController {
  final messageControl = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  void onSubmitClick() async {
    final message = messageControl.text.trim();
    if (message.isEmpty) {
      Toast.info(
        title: "Please enter your message",
        message: "send your issue in the given textbox",
      );
      return;
    }
    if (message.length < 100) {
      Toast.info(
        title: "Please enter your message",
        message: "This message has 100 characters.",
      );
      return;
    }
    final result = await ServicesRepo.raise(message: message);
    if (result is DataSuccess) {
      Get.back();
      Toast.success(
        title: "Request Raised Successfully",
        message: result.data!,
      );
      return;
    }
    if (result is DataFailed) {
      Toast.failed(title: "Unable to raise a request", message: result.error);
      return;
    }
  }
}
