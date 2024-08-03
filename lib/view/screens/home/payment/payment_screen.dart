// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/config/logger.dart';
import 'package:xperience/model/data/repo/reservations_repo.dart';
import 'package:xperience/model/models/reservation_model.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/screens/home/payment/success_screen.dart';
import 'package:xperience/view/screens/main_screen.dart';
import 'package:xperience/view/widgets/components/main_button.dart';
import 'package:xperience/view/widgets/components/main_progress.dart';
import 'package:xperience/view/widgets/dialogs/dialogs_helper.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({
    required this.paymentUrl,
    required this.reservationId,
    this.isFromReservation = false,
    super.key,
  });

  final String paymentUrl;
  final int reservationId;
  final bool isFromReservation;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<PaymentScreen2ViewModel>(
      initState: (model) {},
      model: PaymentScreen2ViewModel(
        context: context,
        reservationId: reservationId,
        reservationsRepo: Provider.of<ReservationRepo>(context),
      ),
      builder: (_, model, child) {
        return PopScope(
          canPop: model.isCanPop,
          onPopInvoked: (value) async {
            final result = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  insetPadding: const EdgeInsets.all(10),
                  title: Text(
                    "Confirmation".localize(context),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  content: Text("Are you sure you want to cancel payment process?".localize(context)),
                  actions: [
                    MainButton(
                      type: ButtonType.text,
                      title: "Cancel".localize(context),
                      color: AppColors.goldColor,
                      onPressed: () => NavService().popKey(),
                    ),
                    MainButton(
                      type: ButtonType.text,
                      title: "Confirm".localize(context),
                      color: AppColors.goldColor,
                      onPressed: () => NavService().popKey(true),
                    ),
                  ],
                );
              },
            );
            if (result == true) {
              model.isCanPop = true;
              if (isFromReservation) {
                NavService().popKey(true);
              } else {
                // NavService().popUntilKey(settings: const RouteSettings(name: RouteNames.mainScreen));
                NavService().pushAndRemoveUntilKey(const MainScreen());
              }
            }
          },
          child: Scaffold(
            // backgroundColor: AppColors.white,
            appBar: AppBar(
              title: Text("Payment".localize(context)),
              // actions: [
              //   Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 10),
              //     child: Text(
              //       "${model.webviewChangeCounter}",
              //       style: const TextStyle(color: Colors.green, fontSize: 20),
              //     ),
              //   ),
              // ],
            ),
            body: model.isBusy
                ? const MainProgress()
                : Stack(
                    children: [
                      InAppWebView(
                        initialUrlRequest: URLRequest(url: WebUri.uri(Uri.parse(paymentUrl))),
                        onWebViewCreated: (InAppWebViewController controller) {
                          model.inAppWebViewController = controller;
                        },
                        onProgressChanged: (InAppWebViewController controller, int progress) {
                          model.progress = progress / 100;
                          model.setState();
                        },
                        onLoadStart: (InAppWebViewController controller, Uri? url) {
                          model.webviewChangeCounter++;
                          String fullUrl = "${url?.host}${url?.path}/?${url?.query}";
                          Logger.printObject({"InAppWebViewControllerURL": fullUrl});
                          /*
                          (1) ---> https://secure-egypt.paytabs.com/payment/wr/5C5DE02E82E5312443D70FC3CEC8CF395837E7AB5F5AA6B16F4BFDAF 
                          (2) ---> https://secure-egypt.paytabs.com/payment/page/5C5DE02E82E5312443D70FC3CEC8CF395837E7AB5F5AA6B16F4BFDAF/start
                          (3) ---> https://secure-egypt.paytabs.com/payment/page/5C5DE02E82E5312443D70FC3CEC8CF395837E7AB5F5AA6B16F4BFDAF/result
                          */
                          //
                          // if (fullUrl.contains("status=Paid")) {
                          //   NavService().pushAndRemoveUntilKey(const SuccessScreen(isSuccess: true));
                          // } else if (fullUrl.contains("status=Fail")) {
                          //   AppMessenger.snackBar(
                          //     context: context,
                          //     message: "Error in payment".localize(context),
                          //   );
                          //   NavService().pushAndRemoveUntilKey(const SuccessScreen(isSuccess: true));
                          // }
                          // if (model.webviewChangeCounter >= 3) {
                          if (model.webviewChangeCounter >= 3 && model.webviewChangeCounter < 4) {
                            model.checkReservationStatus();
                          }
                        },
                      ),
                      model.progress < 1
                          ? LinearProgressIndicator(
                              value: model.progress,
                              color: AppColors.goldColor,
                            )
                          : const SizedBox(),
                    ],
                  ),
          ),
        );
      },
    );
  }
}

class PaymentScreen2ViewModel extends BaseNotifier {
  PaymentScreen2ViewModel({
    required this.context,
    required this.reservationId,
    required this.reservationsRepo,
  });
  final BuildContext context;
  final int reservationId;
  final ReservationRepo reservationsRepo;

  late InAppWebViewController inAppWebViewController;
  bool isCanPop = false;
  double progress = 0;
  int webviewChangeCounter = 0;

  @override
  void dispose() {
    inAppWebViewController.dispose();
    super.dispose();
  }

  checkReservationStatus() async {
    setBusy();
    Future.delayed(const Duration(milliseconds: 3000), () {
      getReservationById(reservationId);
    });
  }

  Future<void> getReservationById(int reservationId) async {
    setBusy();
    var res = await reservationsRepo.getReservationById(reservationId: reservationId);
    if (res.left != null) {
      failure = res.left?.message;
      DialogsHelper.messageDialog(message: "${res.left?.message}");
      setError();
    } else {
      ReservationModel? reservation = res.right;
      if (reservation?.status == "PAID") {
        NavService().pushAndRemoveUntilKey(SuccessScreen(
          isSuccess: true,
          message: "Payment completed successfully".localize(context),
        ));
      } else {
        NavService().pushAndRemoveUntilKey(const SuccessScreen(
          isSuccess: false,
          // message: "We received your request, please wait for your transaction.".localize(context),
        ));
      }
      setIdle();
    }
  }
}


/*

Payment URL =======> https://secure-egypt.paytabs.com/payment/wr/5C7BC50082E4929950748C8CC7F9D009134C8DCCA5BC68952635C7C1


Name: test
Card Number: 4111 1111 1111 1111
Expiry Date: 12/23
CVC: 123
*/