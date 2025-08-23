import 'package:error_fit/core/resources/screen_view.dart';
import 'package:error_fit/features/notifications/main/notifications_controller.dart';
import 'package:error_fit/features/notifications/main/notifications_mobile_view.dart';
import 'package:error_fit/features/notifications/main/notifications_tab_view.dart';
import 'package:error_fit/features/notifications/main/notifications_web_view.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final control = NotificationsController();

  @override
  void initState() {
    control.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenView(
        mobile: NotificationsMobileView(control: control),
        tab: NotificationsTabView(control: control),
        web: NotificationsWebView(control: control),
      ),
    );
  }
}
