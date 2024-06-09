import 'package:flutter/material.dart';
import 'package:xperience/model/data/datasource/reservations_data_source.dart';
import 'package:xperience/model/models/pagination_model.dart';
import 'package:xperience/model/models/reservation_model.dart';
import 'package:xperience/model/services/api/app_failure.dart';
import 'package:xperience/model/services/api/either.dart';

class ReservationRepo extends ChangeNotifier {
  PaginationModel<ReservationModel>? reservationsPaginated;
  int _pageOffset = 0;
  final int _pageLimit = 10;

  Future<Either<AppFailure, PaginationModel<ReservationModel>>> getReservation() async {
    try {
      if (reservationsPaginated == null) {
        _pageOffset = 0;
      } else {
        _pageOffset += _pageLimit;
      }
      var res = await ReservationDataSource.getReservation(
        queryParams: {
          "offset": "$_pageOffset",
          "limit": "$_pageLimit",
        },
      );
      if (res.left != null) {
        return Either(left: res.left);
      } else {
        var tempServicesPaginated = res.right;
        if (reservationsPaginated == null) {
          reservationsPaginated = tempServicesPaginated;
        } else {
          reservationsPaginated?.count = tempServicesPaginated?.count;
          reservationsPaginated?.next = tempServicesPaginated?.next;
          reservationsPaginated?.previous = tempServicesPaginated?.previous;
          reservationsPaginated?.results?.addAll(tempServicesPaginated?.results ?? []);
        }
        return Either(right: res.right);
      }
    } catch (e) {
      return Either(left: AppFailure(message: e.toString()));
    }
  }
}
