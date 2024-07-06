import 'package:flutter/material.dart';
import 'package:xperience/model/data/datasource/cars_services_data_source.dart';
import 'package:xperience/model/models/car_make_model.dart';
import 'package:xperience/model/models/car_service_model.dart';
import 'package:xperience/model/models/pagination_model.dart';
import 'package:xperience/model/models/reservation_booking_model.dart';
import 'package:xperience/model/models/service_options_model.dart';
import 'package:xperience/model/models/subscription_option_model.dart';
import 'package:xperience/model/services/api/app_failure.dart';
import 'package:xperience/model/services/api/either.dart';

class CarsServiceRepo extends ChangeNotifier {
  PaginationModel<CarServiceModel>? carsServicesPaginated;
  PaginationModel<CarMakeModel>? carMakesList;
  PaginationModel<CarMakeModel>? carModelsList;
  int _pageOffset = 0;
  final int _pageLimit = 10;

  Future<Either<AppFailure, CarServiceModel>> getCarServiceById({
    required int carServiceId,
  }) async {
    try {
      var res = await CarsServicesDataSource.getCarServiceById(serviceId: carServiceId);
      if (res.left != null) {
        return Either(left: res.left);
      } else {
        return Either(right: res.right);
      }
    } catch (e) {
      return Either(left: AppFailure(message: e.toString()));
    }
  }

  Future<Either<AppFailure, PaginationModel<CarServiceModel>>> getCarsServices({Map<String, String>? queryParams}) async {
    try {
      if (carsServicesPaginated == null) {
        _pageOffset = 0;
      } else {
        _pageOffset += _pageLimit;
      }
      var res = await CarsServicesDataSource.getCarsServices(
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

  Future<Either<AppFailure, PaginationModel<CarMakeModel>>> getCarMakes({
    Map<String, String>? queryParams,
  }) async {
    try {
      var res = await CarsServicesDataSource.getCarMakes(
        queryParams: queryParams,
      );
      if (res.left != null) {
        return Either(left: res.left);
      } else {
        carMakesList = res.right;
        return Either(right: carMakesList);
      }
    } catch (e) {
      return Either(left: AppFailure(message: e.toString()));
    }
  }

  Future<Either<AppFailure, PaginationModel<CarMakeModel>>> getCarModels({
    Map<String, String>? queryParams,
  }) async {
    try {
      var res = await CarsServicesDataSource.getCarModels(
        queryParams: queryParams,
      );
      if (res.left != null) {
        return Either(left: res.left);
      } else {
        carModelsList = res.right;
        return Either(right: carModelsList);
      }
    } catch (e) {
      return Either(left: AppFailure(message: e.toString()));
    }
  }

  Future<Either<AppFailure, PaginationModel<SubscriptionOptionModel>>> getSubscriptionOptions({
    Map<String, String>? queryParams,
  }) async {
    try {
      var res = await CarsServicesDataSource.getSubscriptionOptions(
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

  Future<Either<AppFailure, PaginationModel<ServiceOptionsModel>>> getServiceOptions({
    Map<String, String>? queryParams,
  }) async {
    try {
      var res = await CarsServicesDataSource.getServiceOptions(
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

  Future<Either<AppFailure, ReservationBookingModel>> bookingCarService({
    required Map<String, dynamic> body,
  }) async {
    try {
      var res = await CarsServicesDataSource.bookingCarService(body: body);
      if (res.left != null) {
        return Either(left: res.left);
      } else {
        return Either(right: res.right);
      }
    } catch (e) {
      return Either(left: AppFailure(message: e.toString()));
    }
  }

  Future<Either<AppFailure, String>> getPaymentURL({
    required Map<String, dynamic> body,
  }) async {
    try {
      var res = await CarsServicesDataSource.getPaymentURL(body: body);
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
