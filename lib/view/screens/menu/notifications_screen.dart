import 'package:flutter/material.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/widgets/notification_item_widget.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<NotificationsScreenModel>(
      model: NotificationsScreenModel(),
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Notifications").localize(context),
            backgroundColor: AppColors.primaryColorDark,
          ),
          body: ListView.separated(
            itemCount: 5,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: ((context, index) {
              return const NotificationItemWidget();
            }),
          ),
        );
      },
    );
  }
}

class NotificationsScreenModel extends BaseNotifier {}
