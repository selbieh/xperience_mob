import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/data/repo/cars_service_repo.dart';
import 'package:xperience/model/models/checkout_data_model.dart';
import 'package:xperience/model/services/app_messenger.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/router/route_names.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/widgets/components/main_error_widget.dart';
import 'package:xperience/view/widgets/components/main_progress.dart';
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
        carsRepo: Provider.of<CarsServiceRepo>(context),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(height: 20, thickness: 0.25),
                          if ((model.checkoutReservationModel?.carReservations ?? []).isNotEmpty) ...[
                            SummaryInfoItem(
                              title: "Car service".localize(context),
                              value: "EGP ${model.checkoutReservationModel?.carReservations?[0].finalPrice ?? 0}",
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
                                          title: "${e.pointsPrice}",
                                          value: "EGP ${e.price ?? 0} X ${e.quantity ?? 0}",
                                        )
                                      : const SizedBox();
                                }).toList(),
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
                            CustomButton(
                              title: "CHECKOUT".localize(context),
                              onPressed: () {
                                NavService().popUntilKey(settings: const RouteSettings(name: RouteNames.carExperience));
                                AppMessenger.snackBar(
                                  backgroundColor: Colors.green.shade800,
                                  title: "Successfully".tr(),
                                  message: "Your successfully created your booking".tr(),
                                );
                              },
                            )
                          ],
                        ],
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
    required this.carsRepo,
  });
  final CarsServiceRepo carsRepo;
  final BuildContext context;

  CheckoutDataModel? checkoutReservationModel;

  Future<void> getCalculateReservationData({required Map<String, dynamic> body}) async {
    setBusy();
    var res = await carsRepo.getCalculateReservationData(body: body);
    if (res.left != null) {
      failure = res.left?.message;
      DialogsHelper.messageDialog(message: "${res.left?.message}");
      setError();
    } else {
      checkoutReservationModel = res.right;
      setIdle();
      // NavService().pushKey(PaymentScreen(
      //   paymentUrl: "${res.right}",
      //   reservationId: reservationId ?? -1,
      // ));
    }
  }
}
