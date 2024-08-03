import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/data/repo/notifications_repo.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/widgets/components/main_error_widget.dart';
import 'package:xperience/view/widgets/components/main_progress.dart';
import 'package:xperience/view/widgets/dialogs/dialogs_helper.dart';
import 'package:xperience/view/widgets/notification_item_widget.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<NotificationsScreenModel>(
      model: NotificationsScreenModel(
        notificationsRepo: Provider.of<NotificationsRepo>(context),
      ),
      initState: (model) {
        model.initScrollController();
        model.notificationsRepo.notificationsPaginated = null;
        model.getNotifications();
      },
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Notifications").localize(context),
            backgroundColor: AppColors.primaryColorDark,
          ),
          body: model.isBusy
              ? const MainProgress()
              : model.hasError
                  ? MainErrorWidget(
                      error: model.failure,
                      onRetry: model.getNotifications,
                    )
                  : RefreshIndicator(
                      color: AppColors.goldColor,
                      onRefresh: model.refreshNotifications,
                      child: (model.notificationsRepo.notificationsPaginated?.results ?? []).isEmpty
                          ? Center(child: Text("No notifications found".tr()))
                          : SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                              controller: model.scrollController,
                              child: Column(
                                children: [
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: (model.notificationsRepo.notificationsPaginated?.results ?? []).length,
                                    separatorBuilder: (context, index) => const SizedBox(height: 10),
                                    itemBuilder: (context, index) {
                                      var item = model.notificationsRepo.notificationsPaginated?.results?[index];
                                      return NotificationItemWidget(notification: item);
                                    },
                                  ),
                                  if (model.isLoadingMore)
                                    const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 15),
                                      child: MainProgress(),
                                    ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                    ),
        );
      },
    );
  }
}

class NotificationsScreenModel extends BaseNotifier {
  NotificationsScreenModel({required this.notificationsRepo});
  final NotificationsRepo notificationsRepo;

  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;

  Future<void> initScrollController() async {
    scrollController.addListener(() async {
      if (scrollController.position.extentAfter == 0) {
        if (!isLoadingMore && notificationsRepo.notificationsPaginated?.next != null) {
          await getNotifications();
        }
      }
    });
  }

  Future<void> refreshNotifications() async {
    notificationsRepo.notificationsPaginated = null;
    await getNotifications();
  }

  Future<void> getNotifications() async {
    if (notificationsRepo.notificationsPaginated == null) {
      setBusy();
    } else {
      isLoadingMore = true;
      setState();
    }
    var res = await notificationsRepo.getNotifications();
    if (res.left != null) {
      isLoadingMore = false;
      failure = res.left?.message;
      DialogsHelper.messageDialog(message: "${res.left?.message}");
      setError();
    } else {
      isLoadingMore = false;
      setIdle();
    }
  }
}
