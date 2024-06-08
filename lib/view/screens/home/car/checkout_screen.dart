import 'package:flutter/material.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/router/route_names.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/widgets/custom_button.dart';
import 'package:xperience/view/widgets/summary_info_item.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<CheckoutViewModel>(
      model: CheckoutViewModel(),
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Payment Summary").localize(context),
            backgroundColor: AppColors.primaryColorDark,
          ),
          body: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SummaryInfoItem(
                  title: "Ride Cost".localize(context),
                  value: "EGP 950",
                ),
                const Divider(height: 20, thickness: 0.25),
                const Text(
                  "Extras",
                  style: TextStyle(color: AppColors.grey, fontWeight: FontWeight.bold),
                ).localize(context),
                const SummaryInfoItem(
                  title: "Pepsi",
                  value: "EGP 70",
                ),
                const SummaryInfoItem(
                  title: "Water",
                  value: "EGP 40",
                ),
                const SummaryInfoItem(
                  title: "Oud Scent",
                  value: "EGP 150",
                ),
                const Divider(height: 20, thickness: 0.25),
                SummaryInfoItem(
                  title: "Subtotal".localize(context),
                  value: "EGP 1310",
                  isBold: true,
                ),
                SummaryInfoItem(
                  title: "Taxes".localize(context),
                  value: "EGP 110",
                ),
                SummaryInfoItem(
                  title: "Service fee".localize(context),
                  value: "EGP 33",
                ),
                SummaryInfoItem(
                  title: "Total".localize(context),
                  value: "EGP 1520",
                  isBold: true,
                ),
                const SizedBox(height: 40),
                CustomButton(
                  title: "CHECKOUT".localize(context),
                  onPressed: () {
                    NavService().popUntilKey(settings: const RouteSettings(name: RouteNames.carExperience));
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class CheckoutViewModel extends BaseNotifier {}
