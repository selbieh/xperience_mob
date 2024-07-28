import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/config/logger.dart';
import 'package:xperience/model/data/repo/cars_service_repo.dart';
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
import 'package:xperience/view/screens/home/payment/payment_screen.dart';
import 'package:xperience/view/widgets/components/main_button.dart';
import 'package:xperience/view/widgets/dialogs/dialogs_helper.dart';

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
        carsRepo: Provider.of<CarsServiceRepo>(context),
        reservation: reservation,
      ),
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Reservation Details").localize(context),
            backgroundColor: AppColors.primaryColorDark,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${FormatHelper.formatStringDateTime(reservation?.createdAt ?? "", pattern: "d/M/yyyy - h:mma")}",
                        style: const TextStyle(fontSize: 12, color: AppColors.greyText),
                      ),
                      Text(
                        reservation?.status ?? "",
                        style: const TextStyle(fontSize: 12, color: AppColors.greyText),
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
                  if (reservation?.status == "WAITING_FOR_PAYMENT")
                    MainButton(
                      width: double.infinity,
                      radius: 10,
                      title: "Pay".localize(context),
                      onPressed: model.getPaymentURL,
                    ),
                  const SizedBox(height: 20),
                  if (reservation?.status != "COMPLETED" && reservation?.status != "WAITING_FOR_PAYMENT")
                    MainButton(
                      type: ButtonType.outlined,
                      width: double.infinity,
                      height: 55,
                      title: "REFUND".localize(context),
                      color: AppColors.red,
                      radius: 10,
                      onPressed: () {
                        if (reservation?.paymentMethod == "Points") {
                          model.refundReservationPoints(context);
                        } else {
                          model.refundReservationPoints(context);
                        }
                      },
                    ),
                  const SizedBox(height: 20),
                  if (reservation?.status == "COMPLETED")
                    MainButton(
                      type: ButtonType.outlined,
                      width: double.infinity,
                      height: 55,
                      title: "BOOK AGAIN".localize(context),
                      color: const Color.fromARGB(255, 177, 174, 166),
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
          ),
        );
      },
    );
  }
}

class PrivacyPolicyScreenModel extends BaseNotifier {
  PrivacyPolicyScreenModel({required this.carsRepo, this.reservation});
  final CarsServiceRepo carsRepo;
  final ReservationModel? reservation;

  Future<void> refundReservationMethod(BuildContext context) async {
    final result = await DialogsHelper.refundMethodDialog(context);
    if (result != null) {
      Logger.printObject(result);
    }
  }

  Future<void> refundReservationPoints(BuildContext context) async {
    final result = await DialogsHelper.approveDialog(
      context,
      title: "Refund",
      subtitle: "Are you sure you want to refund this reservation?",
    );
    if (result != null) {
      Logger.printObject(result);
      refundCarService();
    }
  }

  Future<void> getPaymentURL() async {
    setBusy();
    var res = await carsRepo.getPaymentURL(
      body: {"reservation_id": reservation?.id},
    );
    if (res.left != null) {
      failure = res.left?.message;
      DialogsHelper.messageDialog(message: "${res.left?.message}");
      setError();
    } else {
      setIdle();
      await NavService().pushKey(
        PaymentScreen(
          paymentUrl: "${res.right}",
          isFromReservation: true,
          reservationId: reservation?.id ?? -1,
        ),
      );
    }
  }

  Future<void> refundCarService() async {
    setBusy();
    var res = await carsRepo.refundCarService(
      body: {
        "reservation_id": reservation?.id,
        "refund_method": "POINTS",
      },
    );
    if (res.left != null) {
      failure = res.left?.message;
      DialogsHelper.messageDialog(message: "${res.left?.message}");
      setError();
    } else {
      setIdle();
      NavService().popKey();
    }
  }
}
