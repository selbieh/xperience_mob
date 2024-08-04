import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xperience/model/models/car_service_model.dart';
import 'package:xperience/model/models/hotel_service_model.dart';
import 'package:xperience/model/models/reservation_model.dart';
import 'package:xperience/model/services/app_helper.dart';
import 'package:xperience/model/services/format_helper.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/screens/home/Ultimate/ultimate_start_screen.dart';
import 'package:xperience/view/screens/home/car/car_details_screen.dart';
import 'package:xperience/view/screens/home/hotel/hotel_details_screen.dart';
import 'package:xperience/view/widgets/booknow_button.dart';
import 'package:xperience/view/widgets/components/main_button.dart';

class ReservationItemWidget extends StatelessWidget {
  const ReservationItemWidget({
    this.reservationItem,
    this.onPressedPay,
    super.key,
  });
  final ReservationModel? reservationItem;
  final Function()? onPressedPay;

  @override
  Widget build(BuildContext context) {
    bool isHasHotelBooking = (reservationItem?.hotelReservations ?? []).isNotEmpty;
    bool isHasCarBooking = (reservationItem?.carReservations ?? []).isNotEmpty;
    bool isHasMultiBooking = isHasHotelBooking && isHasCarBooking;
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
          Column(
            children: [
              if (isHasHotelBooking)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: SvgPicture.asset("assets/svgs/ic_hotel_2.svg"),
                ),
              if (isHasCarBooking)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: SvgPicture.asset("assets/svgs/ic_car_2.svg"),
                ),
            ],
          ),
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
                    reservationItem?.status == "WAITING_FOR_PAYMENT"
                        ? MainButton(
                            height: 25,
                            radius: 10,
                            title: "Pay".localize(context),
                            onPressed: onPressedPay,
                          )
                        : Text(
                            // "Done",
                            // reservationItem?.status ?? "",
                            AppHelper.getReservationStatus(reservationItem?.status ?? ""),
                            style: const TextStyle(fontSize: 11, color: AppColors.greyText),
                          ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  isHasMultiBooking
                      ? "Hotel & Car booking".localize(context)
                      : isHasCarBooking
                          ? "Car booking".localize(context)
                          : "Hotel booking".localize(context),
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 10),
                if (isHasHotelBooking)
                  Text(
                    (reservationItem?.hotelReservations ?? []).isNotEmpty ? "${reservationItem?.hotelReservations?[0].hotelService?.name ?? ""} " : "-",
                    style: const TextStyle(fontSize: 12, color: AppColors.greyText),
                  ),
                if (isHasCarBooking)
                  Text(
                    (reservationItem?.carReservations ?? []).isNotEmpty
                        ? "${reservationItem?.carReservations?[0].carService?.model ?? ""}"
                            "${reservationItem?.carReservations?[0].carService?.type ?? ""}"
                            "  - "
                            "${reservationItem?.carReservations?[0].carService?.make ?? ""}"
                        : "-",
                    style: const TextStyle(fontSize: 12, color: AppColors.greyText),
                  ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        // isHasMultiBooking
                        //     ? (reservationItem?.carReservations ?? []).isNotEmpty
                        //         ? "${(double.tryParse("${reservationItem?.hotelReservations?[0].finalPrice}") ?? 0) + (double.tryParse("${reservationItem?.carReservations?[0].finalPrice}") ?? 0)} ${"EGP".localize(context)}"
                        //         : "-"
                        //     : isHasHotelBooking
                        //         ? (reservationItem?.hotelReservations ?? []).isNotEmpty
                        //             ? "${reservationItem?.hotelReservations?[0].finalPrice} ${"EGP".localize(context)}"
                        //             : "-"
                        //         : (reservationItem?.carReservations ?? []).isNotEmpty
                        //             ? "${reservationItem?.carReservations?[0].finalPrice} ${"EGP".localize(context)}"
                        //             : "-",
                        "${reservationItem?.finalReservationPrice} ${"EGP".localize(context)}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.greyText,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (((reservationItem?.carReservations ?? []).isNotEmpty || (reservationItem?.hotelReservations ?? []).isNotEmpty) &&
                        reservationItem?.status == "COMPLETED")
                      BookNowButton(
                        title: "BOOK AGAIN".localize(context),
                        onPressed: () {
                          if (isHasMultiBooking) {
                            NavService().pushKey(const UltimateStartScreen());
                          } else {
                            if (isHasCarBooking) {
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
