import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/models/car_service_model.dart';
import 'package:xperience/model/services/auth/auth_service.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/screens/auth/login_screen.dart';
import 'package:xperience/view/screens/home/car/car_booking_screen.dart';
import 'package:xperience/view/screens/home/car/complete_info_screen.dart';
import 'package:xperience/view/widgets/booknow_button.dart';
import 'package:xperience/view/widgets/components/car_info_item.dart';
import 'package:xperience/view/widgets/components/main_image.dart';
import 'package:xperience/view/widgets/car_feature_border_item.dart';

class CarDetailsScreen extends StatelessWidget {
  const CarDetailsScreen({this.carService, Key? key}) : super(key: key);
  final CarServiceModel? carService;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<CarDetailsViewModel>(
      model: CarDetailsViewModel(
        auth: Provider.of<AuthService>(context),
      ),
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(
            // title: const Text("GLA 250 SUV"),
            title: Text(carService?.model ?? ""),
          ),
          body: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: double.infinity),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColorLight,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                  child: const MainImage.network(
                    imagePath:
                        "https://platform.cstatic-images.com/xlarge/in/v2/stock_photos/695deff6-4f71-47aa-803f-661efa168c87/7dd59989-82ce-4b6b-80bf-20f4bb2f7381.png",
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                // "GLA 250 SUV",
                                carService?.model ?? "",
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                // "Mercedes",
                                carService?.make ?? "",
                                style: const TextStyle(color: AppColors.greyText, fontSize: 14),
                              ),
                              const SizedBox(height: 20),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    CarInfoItem(
                                      title: "Make",
                                      // value: "Mercedes",
                                      value: carService?.make ?? "",
                                    ),
                                    CarInfoItem(
                                      title: "Model",
                                      // value: "GLA 250",
                                      value: carService?.model ?? "",
                                    ),
                                    CarInfoItem(
                                      title: "Year",
                                      // value: "2020",
                                      value: "${carService?.year ?? "-"}",
                                    ),
                                    CarInfoItem(
                                      title: "Color",
                                      // value: "Black",
                                      value: carService?.color ?? "",
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                "Features",
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 10),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    CarFeatureBoarderItem(
                                      icon: "assets/svgs/ic_car.svg",
                                      title: "Type",
                                      // value: "SUV",
                                      value: carService?.type ?? "",
                                    ),
                                    const SizedBox(width: 10),
                                    CarFeatureBoarderItem(
                                      icon: "assets/svgs/ic_people.svg",
                                      title: "Capacity",
                                      // value: "6 People",
                                      value: "${carService?.numberOfSeats} Seats",
                                    ),
                                    const SizedBox(width: 10),
                                    if (carService?.cool ?? false)
                                      const CarFeatureBoarderItem(
                                        icon: "assets/svgs/ic_cool_seat.svg",
                                        title: "Cool Seat",
                                        // value: "Temp Control on seat",
                                        value: "Cool",
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColorLight,
                            // color: const Color(0xFF292d4a),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.grey, width: 0.5),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Choose your plan"),
                              const SizedBox(height: 20),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: model.plansList.map((e) {
                                    bool isSelected = model.selectedPlan == e;
                                    return InkWell(
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 5),
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                                        decoration: BoxDecoration(
                                          color: isSelected ? AppColors.primaryColorDark : null,
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: AppColors.grey, width: 0.5),
                                        ),
                                        child: Text(
                                          e,
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                      onTap: () {
                                        model.selectedPlan = e;
                                        model.setState();
                                      },
                                    );
                                  }).toList(),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "Get your best ride without time limitation",
                                style: TextStyle(color: AppColors.grey, fontSize: 12),
                              ),
                              const SizedBox(height: 20),
                              Center(
                                child: BookNowButton(
                                  title: "BOOK YOUR TRIP",
                                  onPressed: model.goToBooking,
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class CarDetailsViewModel extends BaseNotifier {
  CarDetailsViewModel({required this.auth});
  final AuthService auth;

  String selectedPlan = "RIDE";
  List<String> plansList = [
    "RIDE",
    "TRAVEL",
    "AIRPORT",
  ];

  void goToBooking() {
    if (auth.isLogged) {
      if ((auth.userModel?.user?.email ?? "") == "") {
        NavService().pushKey(const CompleteInfoScreen()).then((value) => setState());
      } else {
        NavService().pushKey(CarBookingScreen(planType: selectedPlan));
      }
    } else {
      NavService().pushKey(const LoginScreen());
    }
  }
}
