import 'package:flutter/material.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
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
            title: const Text("Payment Summary"),
            backgroundColor: AppColors.primaryColorDark,
          ),
          body: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SummaryInfoItem(
                  title: "Ride Cost",
                  value: "EGP 950",
                ),
                const Divider(height: 20, thickness: 0.25),
                const Text(
                  "Extras",
                  style: TextStyle(color: AppColors.grey, fontWeight: FontWeight.bold),
                ),
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
                const SummaryInfoItem(
                  title: "Subtotal",
                  value: "EGP 1310",
                  isBold: true,
                ),
                const SummaryInfoItem(
                  title: "Taxes",
                  value: "EGP 110",
                ),
                const SummaryInfoItem(
                  title: "Service fee",
                  value: "EGP 33",
                ),
                const SummaryInfoItem(
                  title: "Total",
                  value: "EGP 1520",
                  isBold: true,
                ),
                const SizedBox(height: 40),
                CustomButton(
                  title: "CHECKOUT",
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
