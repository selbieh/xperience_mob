import 'package:flutter/material.dart';
import 'package:xperience/model/data/datasource/hotels_services_data_source.dart';
import 'package:xperience/model/models/hotel_service_features_model.dart';
import 'package:xperience/model/models/hotel_service_model.dart';
import 'package:xperience/model/models/pagination_model.dart';
import 'package:xperience/model/models/reservation_booking_model.dart';
import 'package:xperience/model/services/api/app_failure.dart';
import 'package:xperience/model/services/api/either.dart';

class HotelsServiceRepo extends ChangeNotifier {
  PaginationModel<HotelServiceModel>? hotelsServicesPaginated;
  PaginationModel<HotelServiceFeaturesModel>? hotelFeaturesList;
  int _pageOffset = 0;
  final int _pageLimit = 10;

  Future<Either<AppFailure, HotelServiceModel>> getHotelServiceById({
    required int carServiceId,
  }) async {
    try {
      var res = await HotelsServicesDataSource.getHotelServiceById(serviceId: carServiceId);
      if (res.left != null) {
        return Either(left: res.left);
      } else {
        return Either(right: res.right);
      }
    } catch (e) {
      return Either(left: AppFailure(message: e.toString()));
    }
  }

  Future<Either<AppFailure, PaginationModel<HotelServiceModel>>> getHotelsServices({Map<String, String>? queryParams}) async {
    try {
      if (hotelsServicesPaginated == null) {
        _pageOffset = 0;
      } else {
        _pageOffset += _pageLimit;
      }
      var res = await HotelsServicesDataSource.getHotelsServices(
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

  Future<Either<AppFailure, ReservationBookingModel>> bookingHotelService({
    required Map<String, dynamic> body,
  }) async {
    try {
      var res = await HotelsServicesDataSource.bookingHotelService(body: body);
      if (res.left != null) {
        return Either(left: res.left);
      } else {
        return Either(right: res.right);
      }
    } catch (e) {
      return Either(left: AppFailure(message: e.toString()));
    }
  }

  Future<Either<AppFailure, PaginationModel<HotelServiceFeaturesModel>>> getHotelsServiceFeatures({
    Map<String, String>? queryParams,
  }) async {
    try {
      var res = await HotelsServicesDataSource.getHotelsServiceFeatures(
        queryParams: queryParams,
      );
      if (res.left != null) {
        return Either(left: res.left);
      } else {
        hotelFeaturesList = res.right;
        return Either(right: hotelFeaturesList);
      }
    } catch (e) {
      return Either(left: AppFailure(message: e.toString()));
    }
  }
}
