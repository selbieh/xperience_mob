import 'package:flutter/material.dart';
import 'package:xperience/model/data/hotels_remote_data_source.dart';
import 'package:xperience/model/models/hotel_service_model.dart';
import 'package:xperience/model/models/pagination_model.dart';
import 'package:xperience/model/services/api/app_failure.dart';
import 'package:xperience/model/services/api/either.dart';

class HotelsServiceRepo extends ChangeNotifier {
  PaginationModel<HotelServiceModel>? hotelsServicesPaginated;
  int _pageOffset = 0;
  final int _pageLimit = 5;

  Future<Either<AppFailure, PaginationModel<HotelServiceModel>>> getHotelsServices() async {
    try {
      if (hotelsServicesPaginated == null) {
        _pageOffset = 0;
      } else {
        _pageOffset += _pageLimit;
      }
      var res = await HotelsRemoteDataSource.getHotelsServices(
        queryParams: {
          "offset": "$_pageOffset",
          "limit": "$_pageLimit",
        },
      );
      if (res.left != null) {
        return Either(left: res.left);
      } else {
        var tempServicesPaginated = res.right;
        if (hotelsServicesPaginated == null) {
          hotelsServicesPaginated = tempServicesPaginated;
        } else {
          hotelsServicesPaginated?.count = tempServicesPaginated?.count;
          hotelsServicesPaginated?.next = tempServicesPaginated?.next;
          hotelsServicesPaginated?.previous = tempServicesPaginated?.previous;
          hotelsServicesPaginated?.results?.addAll(tempServicesPaginated?.results ?? []);
        }
        return Either(right: res.right);
      }
    } catch (e) {
      return Either(left: AppFailure(message: e.toString()));
    }
  }
}
