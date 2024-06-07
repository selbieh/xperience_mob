import 'package:flutter/material.dart';
import 'package:xperience/model/data/cars_remote_data_source.dart';
import 'package:xperience/model/models/car_service_model.dart';
import 'package:xperience/model/models/pagination_model.dart';
import 'package:xperience/model/services/api/app_failure.dart';
import 'package:xperience/model/services/api/either.dart';

class HotelsServiceRepo extends ChangeNotifier {
  PaginationModel<CarServiceModel>? carsServicesPaginated;
  int _pageOffset = 0;
  final int _pageLimit = 5;

  Future<Either<AppFailure, PaginationModel<CarServiceModel>>> getCarServices() async {
    try {
      if (carsServicesPaginated == null) {
        _pageOffset = 0;
      } else {
        _pageOffset += _pageLimit;
      }
      var res = await CarsRemoteDataSource.getCarServices(
        queryParams: {
          "offset": "$_pageOffset",
          "limit": "$_pageLimit",
        },
      );
      if (res.left != null) {
        return Either(left: res.left);
      } else {
        var tempServicesPaginated = res.right;
        if (carsServicesPaginated == null) {
          carsServicesPaginated = tempServicesPaginated;
        } else {
          carsServicesPaginated?.count = tempServicesPaginated?.count;
          carsServicesPaginated?.next = tempServicesPaginated?.next;
          carsServicesPaginated?.previous = tempServicesPaginated?.previous;
          carsServicesPaginated?.results?.addAll(tempServicesPaginated?.results ?? []);
        }
        return Either(right: res.right);
      }
    } catch (e) {
      return Either(left: AppFailure(message: e.toString()));
    }
  }
}
