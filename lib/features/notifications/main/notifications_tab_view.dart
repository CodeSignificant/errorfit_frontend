import 'package:error_fit/features/notifications/main/notifications_controller.dart';
import 'package:flutter/material.dart';

class NotificationsTabView extends StatefulWidget {
  final NotificationsController control;
  const NotificationsTabView({super.key, required this.control});

  @override
  State<NotificationsTabView> createState() => _NotificationsTabViewState();
}

class _NotificationsTabViewState extends State<NotificationsTabView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
