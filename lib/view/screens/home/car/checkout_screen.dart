// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/data/repo/booking_repo.dart';
import 'package:xperience/model/models/checkout_data_model.dart';
import 'package:xperience/model/models/reservation_booking_model.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/screens/home/payment/payment_screen.dart';
import 'package:xperience/view/screens/home/payment/success_screen.dart';
import 'package:xperience/view/widgets/components/main_error_widget.dart';
import 'package:xperience/view/widgets/components/main_progress.dart';
import 'package:xperience/view/widgets/components/main_textfield.dart';
import 'package:xperience/view/widgets/custom_button.dart';
import 'package:xperience/view/widgets/dialogs/dialogs_helper.dart';
import 'package:xperience/view/widgets/summary_info_item.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({required this.bookingBody, Key? key}) : super(key: key);
  final Map<String, dynamic> bookingBody;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<CheckoutViewModel>(
      model: CheckoutViewModel(
        context: context,
        checkoutRepo: Provider.of<BookingRepo>(context),
        bookingBody: bookingBody,
      ),
      initState: (model) {
        model.getCalculateReservationData(body: bookingBody);
      },
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Payment Summary").localize(context),
            backgroundColor: AppColors.primaryColorDark,
          ),
          body: model.isBusy
              ? const MainProgress()
              : model.hasError
                  ? MainErrorWidget(
                      error: model.failure,
                      onRetry: () => model.getCalculateReservationData(body: bookingBody),
                    )
                  : Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if ((model.checkoutReservationModel?.hotelReservations ?? []).isNotEmpty) ...[
                              const Divider(height: 20, thickness: 0.25),
                              SummaryInfoItem(
                                title: "Hotel service".localize(context),
                                value: "EGP ${model.checkoutReservationModel?.hotelReservations?[0].finalPrice ?? 0}",
                              ),
                              if ((model.checkoutReservationModel?.hotelReservations?[0].options ?? []).isNotEmpty) ...[
                                ...[
                                  const Text(
                                    "Extras",
                                    style: TextStyle(color: AppColors.grey, fontWeight: FontWeight.bold),
                                  ).localize(context),
                                  ...(model.checkoutReservationModel?.hotelReservations![0].options)!.map((e) {
                                    bool isCalculated = (e.quantity ?? 0) - (e.maxFree ?? 0) > 0;
                                    return isCalculated
                                        ? SummaryInfoItem(
                                            // title: "Water",
                                            title: e.serviceOptionName ?? "-",
                                            value: (e.maxFree ?? 0) > 0
                                                ? "(${e.maxFree} Free) EGP ${e.price ?? 0} X ${e.quantity ?? 0}"
                                                : "EGP ${e.price ?? 0} X ${e.quantity ?? 0}",
                                          )
                                        : SummaryInfoItem(
                                            title: e.serviceOptionName ?? "_",
                                            value: "(Free) X ${e.quantity ?? 0}",
                                          );
                                    // : const SizedBox();
                                  }).toList(),
                                ],
                              ],
                            ],
                            if ((model.checkoutReservationModel?.carReservations ?? []).isNotEmpty) ...[
                              const Divider(height: 20, thickness: 0.25),
                              SummaryInfoItem(
                                title: "Car service".localize(context),
                                value: "EGP ${model.checkoutReservationModel?.carReservations?[0].subscriptionOptionPrice ?? 0}",
                              ),
                              if ((model.checkoutReservationModel?.carReservations?[0].options ?? []).isNotEmpty) ...[
                                ...[
                                  const Text(
                                    "Extras",
                                    style: TextStyle(color: AppColors.grey, fontWeight: FontWeight.bold),
                                  ).localize(context),
                                  ...(model.checkoutReservationModel?.carReservations![0].options)!.map((e) {
                                    bool isCalculated = (e.quantity ?? 0) - (e.maxFree ?? 0) > 0;

                                    return isCalculated
                                        ? SummaryInfoItem(
                                            // title: "Water",
                                            title: (e.maxFree ?? 0) > 0 ? "${e.serviceOptionName ?? "-"} (${e.maxFree} Free)" : e.serviceOptionName ?? "-",
                                            value: "EGP ${e.price ?? 0} X ${e.quantity ?? 0}",
                                          )
                                        : SummaryInfoItem(
                                            title: e.serviceOptionName ?? "_",
                                            value: "(Free) X ${e.quantity ?? 0}",
                                          );
                                    // : const SizedBox();
                                  }).toList(),
                                ],
                              ],
                            ],
                            const Divider(height: 20, thickness: 0.25),
                            SummaryInfoItem(
                              title: "Total".localize(context),
                              // value: "EGP 1520",
                              value: "EGP ${model.checkoutReservationModel?.finalReservationPrice ?? 0}",
                              isBold: true,
                            ),
                            const SizedBox(height: 50),
                            MainTextField(
                              controller: model.promocodeController,
                              hint: "Promocode".localize(context),
                              keyboardType: TextInputType.text,
                              isFilled: true,
                              fillColor: AppColors.primaryColorLight,
                              prefixIcon: const Padding(
                                padding: EdgeInsets.all(14),
                                child: Icon(Icons.discount_outlined),
                              ),
                            ),
                            const SizedBox(height: 50),
                            model.bookingLoading
                                ? const MainProgress()
                                : CustomButton(
                                    title: "CHECKOUT".localize(context),
                                    onPressed: model.bookingCarService,
                                  )
                          ],
                        ),
                      ),
                    ),
        );
      },
    );
  }
}

class CheckoutViewModel extends BaseNotifier {
  CheckoutViewModel({
    required this.context,
    required this.checkoutRepo,
    required this.bookingBody,
  }) {
    selectedPaymentMethod = bookingBody["payment_method"];
  }

  final BuildContext context;
  final BookingRepo checkoutRepo;
  final Map<String, dynamic> bookingBody;

  CheckoutDataModel? checkoutReservationModel;
  String? selectedPaymentMethod;
  bool bookingLoading = false;
  ReservationBookingModel? reservationBookingModel;
  final promocodeController = TextEditingController();

  Future<void> getCalculateReservationData({required Map<String, dynamic> body}) async {
    setBusy();
    var res = await checkoutRepo.getCalculateReservationData(body: body);
    if (res.left != null) {
      failure = res.left?.message;
      DialogsHelper.messageDialog(message: "${res.left?.message}");
      setError();
    } else {
      checkoutReservationModel = res.right;
      setIdle();
    }
  }

  Future<void> bookingCarService() async {
    try {
      bookingLoading = true;
      setState();
      var res = await checkoutRepo.bookingServices(
        // body: bookingBody,
        body: {
          ...bookingBody,
          "promocode": promocodeController.text,
        },
      );
      bookingLoading = false;
      if (res.left != null) {
        failure = res.left?.message;
        DialogsHelper.messageDialog(message: "${res.left?.message}");
        setError();
      } else {
        reservationBookingModel = res.right;
        if (selectedPaymentMethod == "CREDIT_CARD") {
          getPaymentURL(reservationBookingModel?.id);
        } else {
          setIdle();
          NavService().pushAndRemoveUntilKey(SuccessScreen(
            isSuccess: true,
            message: "Reservation completed successfully".localize(context),
          ));
        }
      }
    } catch (e) {
      bookingLoading = false;
      failure = e.toString();
      DialogsHelper.messageDialog(message: "$e");
      setError();
    }
  }

  Future<void> getPaymentURL(int? reservationId) async {
    var res = await checkoutRepo.getPaymentURL(
      body: {"reservation_id": reservationId},
    );
    if (res.left != null) {
      failure = res.left?.message;
      DialogsHelper.messageDialog(message: "${res.left?.message}");
      setError();
    } else {
      setIdle();
      NavService().pushKey(PaymentScreen(
        paymentUrl: "${res.right}",
        reservationId: reservationId ?? -1,
      ));
    }
  }
}
