import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/config/logger.dart';
import 'package:xperience/model/services/app_messenger.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/router/route_names.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/screens/home/payment/success_screen.dart';
import 'package:xperience/view/widgets/components/main_button.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({
    required this.paymentUrl,
    this.isFromReservation = false,
    super.key,
  });

  final String paymentUrl;
  final bool isFromReservation;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<PaymentScreen2ViewModel>(
      initState: (model) {},
      model: PaymentScreen2ViewModel(context: context),
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
                NavService().popKey();
              } else {
                NavService().popUntilKey(settings: const RouteSettings(name: RouteNames.mainScreen));
              }
            }
          },
          child: Scaffold(
            appBar: AppBar(title: Text("Payment".localize(context))),
            body: Stack(
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
                    String fullUrl = "${url?.host}${url?.path}/?${url?.query}";
                    Logger.log("InAppWebViewController URL ===> $fullUrl");
                    Logger.printObject({"InAppWebViewControllerURL": fullUrl});
                    // https://um-in.com/myTickets/?status=Paid // success URL
                    // https://secure-egypt.paytabs.com/payment/page/5C7BC50082E4929950748C8CC7F9D009134C8DCCA5BC68952635C7C1/result
                    if (fullUrl.contains("status=Paid")) {
                      NavService().pushAndRemoveUntilKey(const SuccessScreen(isSuccess: true));
                      // https://um-in.com/myTickets/?status=Fail // Fail URL
                    } else if (fullUrl.contains("status=Fail")) {
                      AppMessenger.snackBar(
                        context: context,
                        message: "Error in payment".localize(context),
                      );
                      NavService().pushAndRemoveUntilKey(const SuccessScreen(isSuccess: true));
                    }
                  },
                ),
                model.progress < 1
                    ? LinearProgressIndicator(
                        value: model.progress,
                        color: AppColors.goldColor,
                      )
                    : const SizedBox()
              ],
            ),
          ),
        );
      },
    );
  }
}

class PaymentScreen2ViewModel extends BaseNotifier {
  PaymentScreen2ViewModel({required this.context});
  final BuildContext context;

  late InAppWebViewController inAppWebViewController;
  bool isCanPop = false;
  double progress = 0;
}


/*

Payment URL =======> https://secure-egypt.paytabs.com/payment/wr/5C7BC50082E4929950748C8CC7F9D009134C8DCCA5BC68952635C7C1


Name: test
Card Number: 4111 1111 1111 1111
Expiry Date: 12/23
CVC: 123
*/