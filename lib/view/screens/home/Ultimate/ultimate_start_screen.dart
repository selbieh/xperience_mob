import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/services/auth/auth_service.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/screens/auth/login_screen.dart';
import 'package:xperience/view/screens/home/Ultimate/ultimate_step_1_hotel.dart';
import 'package:xperience/view/screens/home/car/complete_info_screen.dart';
import 'package:xperience/view/widgets/components/main_button.dart';

class UltimateStartScreen extends StatelessWidget {
  const UltimateStartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<UltimateStartViewModel>(
      model: UltimateStartViewModel(
        auth: Provider.of<AuthService>(context),
      ),
      builder: (_, model, child) {
        return Scaffold(
          backgroundColor: AppColors.primaryColorDark,
          appBar: AppBar(
            backgroundColor: AppColors.primaryColorDark,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome to".localize(context),
                          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w300, height: 0),
                        ),
                        Text(
                          "ULTIMATE".localize(context),
                          style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, height: 0),
                        ),
                        Text(
                          "EXPERIENCE".localize(context),
                          style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, height: 0),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Book your ride and hotel".localize(context),
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          "seamlessly for a VIP experience.".localize(context),
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Choose the property".localize(context),
                            "Choose your perfect car".localize(context),
                            "Review & Confirm".localize(context),
                          ]
                              .map(
                                (e) => Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  child: Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: [
                                      Container(
                                        height: 8,
                                        width: 8,
                                        decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.goldColor),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        e,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                MainButton(
                  radius: 10,
                  height: 60,
                  width: double.infinity,
                  color: AppColors.goldColor,
                  textStyle: const TextStyle(color: AppColors.black),
                  title: "GET STARTED".localize(context),
                  onPressed: model.getStart,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class UltimateStartViewModel extends BaseNotifier {
  UltimateStartViewModel({required this.auth});
  final AuthService auth;

  void getStart() {
    if (auth.isLogged) {
      if ((auth.userModel?.user?.email ?? "") == "") {
        NavService().pushKey(const CompleteInfoScreen()).then((value) => setState());
      } else {
        NavService().pushKey(const UltimateStep1HotelScreen());
      }
    } else {
      NavService().pushKey(const LoginScreen());
    }
  }
}
