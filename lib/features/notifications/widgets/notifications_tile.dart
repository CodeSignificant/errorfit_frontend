import 'package:error_fit/config/extensions/string_extensions.dart';
import 'package:error_fit/config/styles/app_colors.dart';
import 'package:error_fit/config/styles/decorations.dart';
import 'package:error_fit/config/styles/font_styles.dart';
import 'package:error_fit/core/buttons/anim_button.dart';
import 'package:error_fit/core/images/ImageLoader.dart';
import 'package:error_fit/features/notifications/models/notifications_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationsTile extends StatelessWidget {
  final NotificationsModel model;
  final Function(NotificationsModel model) onNotificationClick;

  const NotificationsTile({
    super.key,
    required this.model,
    required this.onNotificationClick,
  });

  @override
  Widget build(BuildContext context) {
    return AnimButton(
      onClick: () => onNotificationClick(model),
      child: Container(
        decoration: Decorations.card,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            ImageLoader(
              url: model.image.autoUrl,
              height: 60,
              width: 60,
              radius: 0,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(model.title, style: FontStyles.s16Primary7),
                      ),
                      const SizedBox(width: 10),
                      Obx(() {
                        return Visibility(
                          visible: !model.isRead.value,
                          child: Container(
                            decoration: Decorations.dot(color: AppColors.green),
                            height: 8,
                            width: 8,
                          ),
                        );
                      }),
                    ],
                  ),
                  // const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(model.createdAt, style: FontStyles.s12Grey4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Obx(() {
                          return Text(
                            model.status.value,
                            style: FontStyles.s12Grey4,
                          );
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    model.message,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: FontStyles.s14Primary706,
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
