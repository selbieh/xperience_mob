import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xperience/model/models/car_service_model.dart';
import 'package:xperience/model/models/hotel_service_model.dart';
import 'package:xperience/model/models/reservation_model.dart';
import 'package:xperience/model/services/format_helper.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/screens/home/car/car_details_screen.dart';
import 'package:xperience/view/screens/home/hotel/hotel_details_screen.dart';
import 'package:xperience/view/widgets/booknow_button.dart';

class ReservationItemWidget extends StatelessWidget {
  const ReservationItemWidget({
    this.reservationItem,
    super.key,
  });
  final ReservationModel? reservationItem;

  @override
  Widget build(BuildContext context) {
    bool isCarBooking = (reservationItem?.carReservations ?? []).isNotEmpty;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.greyText, width: 0.25),
        borderRadius: BorderRadius.circular(10),
        color: AppColors.primaryColorLight,
      ),
      child: Row(
        children: [
          SvgPicture.asset(isCarBooking ? "assets/svgs/ic_car_2.svg" : "assets/svgs/ic_hotel_2.svg"),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      // "5/19/2024 - 11:12PM",
                      "${FormatHelper.formatStringDateTime(reservationItem?.createdAt ?? "", pattern: "d/M/yyyy - h:mma")}",
                      style: const TextStyle(fontSize: 11, color: AppColors.greyText),
                    ),
                    Text(
                      // "Done",
                      reservationItem?.status ?? "",
                      style: const TextStyle(fontSize: 11, color: AppColors.greyText),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  isCarBooking ? "Car booking".localize(context) : "Hotel booking".localize(context),
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 10),
                Text(
                  isCarBooking
                      ? (reservationItem?.carReservations ?? []).isNotEmpty
                          ? "${reservationItem?.carReservations?[0].carService?.model ?? ""} ${reservationItem?.carReservations?[0].carService?.type ?? ""}  - ${reservationItem?.carReservations?[0].carService?.make ?? ""}"
                          : "-"
                      : (reservationItem?.hotelReservations ?? []).isNotEmpty
                          ? "${reservationItem?.hotelReservations?[0].hotelService?.name ?? ""} "
                          : "-",
                  style: const TextStyle(fontSize: 12, color: AppColors.greyText),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        isCarBooking
                            ? (reservationItem?.carReservations ?? []).isNotEmpty
                                ? "${reservationItem?.carReservations?[0].finalPrice} ${"EGP".localize(context)}"
                                : "-"
                            : (reservationItem?.hotelReservations ?? []).isNotEmpty
                                ? "${reservationItem?.hotelReservations?[0].finalPrice} ${"EGP".localize(context)}"
                                : "-",
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.greyText,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if ((reservationItem?.carReservations ?? []).isNotEmpty || (reservationItem?.hotelReservations ?? []).isNotEmpty)
                      BookNowButton(
                        title: "BOOK AGAIN".localize(context),
                        onPressed: () {
                          if (isCarBooking) {
                            NavService().pushKey(
                              CarDetailsScreen(
                                carService: CarServiceModel(id: reservationItem?.carReservations?[0].carService?.id ?? -1),
                              ),
                            );
                          } else {
                            NavService().pushKey(
                              HotelDetailsScreen(
                                hotelService: HotelServiceModel(id: reservationItem?.hotelReservations?[0].hotelService?.id ?? -1),
                              ),
                            );
                          }
                        },
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
