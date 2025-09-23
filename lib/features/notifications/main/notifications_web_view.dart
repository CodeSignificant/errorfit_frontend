import 'package:error_fit/core/app_bars/main_app_bar.dart';
import 'package:error_fit/core/images/svg_icon.dart';
import 'package:error_fit/core/resources/center_max.dart';
import 'package:error_fit/core/resources/center_tab.dart';
import 'package:error_fit/features/notifications/main/notifications_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/loading_view.dart';
import '../widgets/notifications_tile.dart';

class NotificationsWebView extends StatefulWidget {
  final NotificationsController control;

  const NotificationsWebView({super.key, required this.control});

  @override
  State<NotificationsWebView> createState() => _NotificationsWebViewState();
}

class _NotificationsWebViewState extends State<NotificationsWebView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MainAppBar(),
        Expanded(
          child: LoadingView(
            controller: widget.control.loadingController,
            child: Obx(() {
              final list = widget.control.notificationsList.value;
              return MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: CenterMax(
                  child: Row(
                    children: [

                      SvgIcon(path: "ill_notification", size: 360,),

                      Expanded(
                        child: ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (context, index) =>
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 12,
                                  right: 12,
                                  bottom: 10.0,
                                  top: index == 0 ? 10 : 0,
                                ),
                                child: CenterTab(
                                  child: NotificationsTile(
                                    model: list[index],
                                    onNotificationClick:
                                    widget.control.onNotificationClick,
                                  ),
                                ),
                              ),
                        ),
                      ),

                    ],
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
