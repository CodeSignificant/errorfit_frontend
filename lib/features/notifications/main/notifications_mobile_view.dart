import 'package:error_fit/core/app_bars/title_appbar.dart';
import 'package:error_fit/core/widgets/loading_view.dart';
import 'package:error_fit/features/notifications/main/notifications_controller.dart';
import 'package:error_fit/features/notifications/widgets/notifications_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationsMobileView extends StatefulWidget {
  final NotificationsController control;

  const NotificationsMobileView({super.key, required this.control});

  @override
  State<NotificationsMobileView> createState() =>
      _NotificationsMobileViewState();
}

class _NotificationsMobileViewState extends State<NotificationsMobileView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TitleAppBar(title: "Notifications"),
        Expanded(
          child: LoadingView(
            controller: widget.control.loadingController,
            child: Obx(() {
              final list = widget.control.notificationsList.value;
              return MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(
                      left: 12,
                      right: 12,
                      bottom: 10.0,
                      top: index == 0 ? 10 : 0,
                    ),
                    child: NotificationsTile(
                      model: list[index],
                      onNotificationClick: widget.control.onNotificationClick,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
