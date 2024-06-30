import 'package:flutter/material.dart';
import 'package:xperience/model/data/datasource/notitfication_data_source.dart';
import 'package:xperience/model/models/notification_model.dart';
import 'package:xperience/model/models/pagination_model.dart';
import 'package:xperience/model/services/api/app_failure.dart';
import 'package:xperience/model/services/api/either.dart';

class NotificationsRepo extends ChangeNotifier {
  PaginationModel<NotificationModel>? notificationsPaginated;
  int _pageOffset = 0;
  final int _pageLimit = 10;

  Future<Either<AppFailure, PaginationModel<NotificationModel>>> getNotifications() async {
    try {
      if (notificationsPaginated == null) {
        _pageOffset = 0;
      } else {
        _pageOffset += _pageLimit;
      }
      var res = await NotificationDataSource.getNotifications(
        queryParams: {
          "offset": "$_pageOffset",
          "limit": "$_pageLimit",
        },
      );
      if (res.left != null) {
        return Either(left: res.left);
      } else {
        var tempServicesPaginated = res.right;
        if (notificationsPaginated == null) {
          notificationsPaginated = tempServicesPaginated;
        } else {
          notificationsPaginated?.count = tempServicesPaginated?.count;
          notificationsPaginated?.next = tempServicesPaginated?.next;
          notificationsPaginated?.previous = tempServicesPaginated?.previous;
          notificationsPaginated?.results?.addAll(tempServicesPaginated?.results ?? []);
        }
        return Either(right: res.right);
      }
    } catch (e) {
      return Either(left: AppFailure(message: e.toString()));
    }
  }
}
