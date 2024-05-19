import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/services/theme/app_colors.dart';

class MyReservationsScreen extends StatelessWidget {
  const MyReservationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<MyReservationsScreenModel>(
      model: MyReservationsScreenModel(),
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("My resevations"),
            backgroundColor: AppColors.primaryColorDark,
          ),
          body: ListView.separated(
            itemCount: 5,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: ((context, index) {
              return const ReservationItemWidget();
            }),
          ),
        );
      },
    );
  }
}

class ReservationItemWidget extends StatelessWidget {
  const ReservationItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
          SvgPicture.asset("assets/svgs/ic_hotel_2.svg"),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "5/19/2024 - 11:12PM",
                      style: TextStyle(fontSize: 11, color: AppColors.greyText),
                    ),
                    Text(
                      "Done",
                      style: TextStyle(fontSize: 11, color: AppColors.greyText),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  "Hotel booking",
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 10),
                const Text(
                  "GLA 250 SUV - Mercedes",
                  style: TextStyle(fontSize: 12, color: AppColors.greyText),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        "EGP 2570",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.greyText,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.goldColor),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColorLight,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                        ),
                        child: const Text(
                          "BOOK AGAIN",
                          style: TextStyle(fontSize: 10),
                        ),
                        onPressed: () {},
                      ),
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

class MyReservationsScreenModel extends BaseNotifier {}
