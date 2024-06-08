import 'package:flutter/material.dart';
import 'package:xperience/model/data/cars_remote_data_source.dart';
import 'package:xperience/model/models/car_make_model.dart';
import 'package:xperience/model/models/car_service_model.dart';
import 'package:xperience/model/models/pagination_model.dart';
import 'package:xperience/model/models/subscription_option_model.dart';
import 'package:xperience/model/services/api/app_failure.dart';
import 'package:xperience/model/services/api/either.dart';

class CarsServiceRepo extends ChangeNotifier {
  PaginationModel<CarServiceModel>? carsServicesPaginated;
  PaginationModel<CarMakeModel>? carMakesPaginated;
  int _pageOffset = 0;
  final int _pageLimit = 10;

  Future<Either<AppFailure, PaginationModel<CarServiceModel>>> getCarsServices({Map<String, String>? queryParams}) async {
    try {
      if (carsServicesPaginated == null) {
        _pageOffset = 0;
      } else {
        _pageOffset += _pageLimit;
      }
      var res = await CarsRemoteDataSource.getCarsServices(
        queryParams: {
          "offset": "$_pageOffset",
          "limit": "$_pageLimit",
          ...queryParams ?? {},
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

  Future<Either<AppFailure, PaginationModel<CarMakeModel>>> getCarMakes() async {
    try {
      var res = await CarsRemoteDataSource.getCarMakes(
        queryParams: {
          "offset": "0",
          "limit": "100",
        },
      );
      if (res.left != null) {
        return Either(left: res.left);
      } else {
        carMakesPaginated = res.right;
        return Either(right: carMakesPaginated);
      }
    } catch (e) {
      return Either(left: AppFailure(message: e.toString()));
    }
  }

  Future<Either<AppFailure, PaginationModel<SubscriptionOptionModel>>> getSubscriptionOptions({
    Map<String, String>? queryParams,
  }) async {
    try {
      var res = await CarsRemoteDataSource.getSubscriptionOptions(
        queryParams: queryParams,
      );
      if (res.left != null) {
        return Either(left: res.left);
      } else {
        return Either(right: res.right);
      }
    } catch (e) {
      return Either(left: AppFailure(message: e.toString()));
    }
  }
}
