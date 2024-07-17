import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/data/repo/info_repo.dart';
import 'package:xperience/model/models/car_service_model.dart';
import 'package:xperience/model/models/hotel_service_model.dart';
import 'package:xperience/model/models/reservation_model.dart';
import 'package:xperience/model/services/format_helper.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/screens/home/Ultimate/ultimate_start_screen.dart';
import 'package:xperience/view/screens/home/car/car_details_screen.dart';
import 'package:xperience/view/screens/home/hotel/hotel_details_screen.dart';
import 'package:xperience/view/widgets/components/main_button.dart';

class ReservationDetailsScreen extends StatelessWidget {
  const ReservationDetailsScreen({
    this.reservation,
    Key? key,
  }) : super(key: key);

  final ReservationModel? reservation;

  @override
  Widget build(BuildContext context) {
    bool isHasHotelBooking = (reservation?.hotelReservations ?? []).isNotEmpty;
    bool isHasCarBooking = (reservation?.carReservations ?? []).isNotEmpty;
    bool isHasMultiBooking = isHasHotelBooking && isHasCarBooking;

    return BaseWidget<PrivacyPolicyScreenModel>(
      model: PrivacyPolicyScreenModel(
        infoRepo: Provider.of<InfoRepo>(context),
      ),
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Reservation Details").localize(context),
            backgroundColor: AppColors.primaryColorDark,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${FormatHelper.formatStringDateTime(reservation?.createdAt ?? "", pattern: "d/M/yyyy - h:mma")}",
                      style: const TextStyle(fontSize: 14, color: AppColors.greyText),
                    ),
                    Text(
                      reservation?.status ?? "",
                      style: const TextStyle(fontSize: 14, color: AppColors.greyText),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isHasMultiBooking
                          ? "Hotel & Car booking".localize(context)
                          : isHasCarBooking
                              ? "Car booking".localize(context)
                              : "Hotel booking".localize(context),
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(),
                    const SizedBox(),
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
                  ],
                ),
                const SizedBox(height: 20),
                if (isHasHotelBooking)
                  Text(
                    (reservation?.hotelReservations ?? []).isNotEmpty ? "${reservation?.hotelReservations?[0].hotelService?.name ?? ""} " : "-",
                    style: const TextStyle(fontSize: 14, color: AppColors.greyText),
                  ),
                const SizedBox(height: 20),
                if (isHasCarBooking)
                  Text(
                    (reservation?.carReservations ?? []).isNotEmpty
                        ? "${reservation?.carReservations?[0].carService?.model ?? ""}"
                            "${reservation?.carReservations?[0].carService?.type ?? ""}"
                            "  - "
                            "${reservation?.carReservations?[0].carService?.make ?? ""}"
                        : "-",
                    style: const TextStyle(fontSize: 14, color: AppColors.greyText),
                  ),
                const SizedBox(height: 20),
                Text(
                  isHasMultiBooking
                      ? (reservation?.carReservations ?? []).isNotEmpty
                          ? "${(double.tryParse("${reservation?.hotelReservations?[0].finalPrice}") ?? 0) + (double.tryParse("${reservation?.carReservations?[0].finalPrice}") ?? 0)} ${"EGP".localize(context)}"
                          : "-"
                      : isHasHotelBooking
                          ? (reservation?.hotelReservations ?? []).isNotEmpty
                              ? "${reservation?.hotelReservations?[0].finalPrice} ${"EGP".localize(context)}"
                              : "-"
                          : (reservation?.carReservations ?? []).isNotEmpty
                              ? "${reservation?.carReservations?[0].finalPrice} ${"EGP".localize(context)}"
                              : "-",
                  style: const TextStyle(
                    fontSize: 18,
                    color: AppColors.greyText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                MainButton(
                  type: ButtonType.outlined,
                  width: double.infinity,
                  height: 55,
                  title: "REFUND".localize(context),
                  // color: AppColors.white,
                  color: AppColors.red,
                  radius: 10,
                  onPressed: () async {},
                ),
                const SizedBox(height: 20),
                MainButton(
                  type: ButtonType.outlined,
                  width: double.infinity,
                  height: 55,
                  title: "BOOK AGAIN".localize(context),
                  // color: AppColors.white,
                  color: AppColors.goldColor,
                  radius: 10,
                  onPressed: () {
                    if (isHasMultiBooking) {
                      NavService().pushKey(const UltimateStartScreen());
                    } else {
                      if (isHasCarBooking) {
                        NavService().pushKey(
                          CarDetailsScreen(
                            carService: CarServiceModel(id: reservation?.carReservations?[0].carService?.id ?? -1),
                          ),
                        );
                      } else {
                        NavService().pushKey(
                          HotelDetailsScreen(
                            hotelService: HotelServiceModel(id: reservation?.hotelReservations?[0].hotelService?.id ?? -1),
                          ),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class PrivacyPolicyScreenModel extends BaseNotifier {
  PrivacyPolicyScreenModel({required this.infoRepo});
  final InfoRepo infoRepo;
}
