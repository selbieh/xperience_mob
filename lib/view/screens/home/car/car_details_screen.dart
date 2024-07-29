import 'package:flutter/material.dart';
import 'package:panorama_viewer/panorama_viewer.dart';
import 'package:provider/provider.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/config/size_config.dart';
import 'package:xperience/model/data/repo/cars_service_repo.dart';
import 'package:xperience/model/models/car_service_model.dart';
import 'package:xperience/model/services/auth/auth_service.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/screens/auth/login_screen.dart';
import 'package:xperience/view/screens/home/car/car_booking_screen.dart';
import 'package:xperience/view/screens/home/car/car_panorama_preview_screen.dart';
import 'package:xperience/view/screens/home/car/complete_info_screen.dart';
import 'package:xperience/view/widgets/booknow_button.dart';
import 'package:xperience/view/widgets/components/car_info_item.dart';
import 'package:xperience/view/widgets/car_feature_border_item.dart';
import 'package:xperience/view/widgets/components/main_progress.dart';
import 'package:xperience/view/widgets/components/text_expansion.dart';
import 'package:xperience/view/widgets/dialogs/dialogs_helper.dart';

class CarDetailsScreen extends StatelessWidget {
  const CarDetailsScreen({
    this.carService,
    this.isFromUltimate = false,
    Key? key,
  }) : super(key: key);

  final CarServiceModel? carService;
  final bool isFromUltimate;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<CarDetailsViewModel>(
      initState: (model) {
        model.getCarServiceById(carService?.id ?? -1);
      },
      model: CarDetailsViewModel(
        auth: Provider.of<AuthService>(context),
        carsRepo: Provider.of<CarsServiceRepo>(context),
      ),
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(title: Text(model.carServiceModel?.modelName ?? "")),
          body: model.isBusy
              ? const MainProgress()
              : Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(0),
                  child: SingleChildScrollView(
                    physics: const RangeMaintainingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: double.infinity),
                        if (model.selectedImageIndex != -1)
                          InkWell(
                            child: SizedBox(
                              height: 0.25.h,
                              width: double.infinity,
                              child: PanoramaViewer(
                                child: Image.network(model.carServiceModel?.images?[model.selectedImageIndex ?? 0].image ?? ""),
                              ),
                            ),
                            onTap: () {
                              NavService().pushKey(
                                PanoramaPreviewScreen(
                                  imageUrl: model.carServiceModel?.images?[model.selectedImageIndex ?? 0].image ?? "",
                                ),
                              );
                            },
                          ),
                        if (model.selectedImageIndex != -1)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                            decoration: const BoxDecoration(
                              color: AppColors.primaryColorLight,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            // child: const SizedBox(height: 10, width: double.infinity),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.arrow_back),
                                  onPressed: () {
                                    if ((model.selectedImageIndex ?? 0) > 0) {
                                      model.selectedImageIndex = (model.selectedImageIndex ?? 0) - 1;
                                      model.setState();
                                    }
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.arrow_forward),
                                  onPressed: () {
                                    // if ((model.selectedImageIndex ?? 0) < model.image360List.length - 1) {
                                    if ((model.selectedImageIndex ?? 0) < (model.carServiceModel?.images?.length ?? 0) - 1) {
                                      model.selectedImageIndex = (model.selectedImageIndex ?? 0) + 1;
                                      model.setState();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        // Container(
                        //   padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        //   decoration: const BoxDecoration(
                        //     color: AppColors.primaryColorLight,
                        //     borderRadius: BorderRadius.only(
                        //       bottomLeft: Radius.circular(15),
                        //       bottomRight: Radius.circular(15),
                        //     ),
                        //   ),
                        //   child: const MainImage.network(
                        //     imagePath:
                        //         "https://platform.cstatic-images.com/xlarge/in/v2/stock_photos/695deff6-4f71-47aa-803f-661efa168c87/7dd59989-82ce-4b6b-80bf-20f4bb2f7381.png",
                        //     width: double.infinity,
                        //     fit: BoxFit.cover,
                        //   ),
                        // ),
                        // Expanded(
                        //   child: SingleChildScrollView(
                        // physics: const BouncingScrollPhysics(),
                        Column(
                          children: [
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    // "GLA 250 SUV",
                                    model.carServiceModel?.modelName ?? "-",
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    // "Mercedes",
                                    model.carServiceModel?.makeName ?? "-",
                                    style: const TextStyle(color: AppColors.greyText, fontSize: 14),
                                  ),
                                  const SizedBox(height: 20),
                                  if ((model.carServiceModel?.description ?? "").isNotEmpty)
                                    TextExpansion(
                                      // text: "dasdasd dasdas  d dasdasd dasdasdasd das" * 5,
                                      text: model.carServiceModel?.description ?? "",
                                      maxLines: 1,
                                    ),
                                  const SizedBox(height: 20),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        CarInfoItem(
                                          title: "Make".localize(context),
                                          // value: "Mercedes",
                                          value: carService?.makeName ?? "-",
                                        ),
                                        CarInfoItem(
                                          title: "Model".localize(context),
                                          // value: "GLA 250",
                                          value: model.carServiceModel?.modelName ?? "-",
                                        ),
                                        CarInfoItem(
                                          title: "Year".localize(context),
                                          // value: "2020",
                                          value: "${carService?.year ?? "-"}",
                                        ),
                                        CarInfoItem(
                                          title: "Color".localize(context),
                                          // value: "Black",
                                          value: carService?.color ?? "-",
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const Text(
                                    "Features",
                                    style: TextStyle(fontSize: 16),
                                  ).localize(context),
                                  const SizedBox(height: 10),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        CarFeatureBoarderItem(
                                          icon: "assets/svgs/ic_car.svg",
                                          title: "Type".localize(context),
                                          // value: "SUV",
                                          value: carService?.type ?? "",
                                        ),
                                        const SizedBox(width: 10),
                                        CarFeatureBoarderItem(
                                          icon: "assets/svgs/ic_people.svg",
                                          title: "Capacity".localize(context),
                                          // value: "6 People",
                                          value: "${carService?.numberOfSeats} ${"Seats".localize(context)}",
                                        ),
                                        const SizedBox(width: 10),
                                        if (carService?.cool ?? false)
                                          CarFeatureBoarderItem(
                                            icon: "assets/svgs/ic_cool_seat.svg",
                                            title: "Cool Seat".localize(context),
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
                                  const Text("Choose your plan").localize(context),
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
                                              color: isSelected ? AppColors.selectedColor : null,
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
                                  ).localize(context),
                                  const SizedBox(height: 20),
                                  if (isFromUltimate == false)
                                    Center(
                                      child: BookNowButton(
                                        title: "BOOK YOUR TRIP".localize(context),
                                        onPressed: model.goToBooking,
                                      ),
                                    ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
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

class CarDetailsViewModel extends BaseNotifier {
  CarDetailsViewModel({required this.auth, required this.carsRepo});
  final AuthService auth;
  final CarsServiceRepo carsRepo;

  CarServiceModel? carServiceModel;
  int? selectedImageIndex = -1;

  List<String> plansList = [
    "RIDE",
    "TRAVEL",
    "AIRPORT",
  ];
  String selectedPlan = "RIDE";

  void goToBooking() {
    if (auth.isLogged) {
      if ((auth.userModel?.user?.email ?? "") == "") {
        NavService().pushKey(const CompleteInfoScreen()).then((value) => setState());
      } else {
        NavService().pushKey(CarBookingScreen(
          planType: selectedPlan,
          carServiceId: carServiceModel?.id ?? -1,
        ));
      }
    } else {
      NavService().pushKey(const LoginScreen());
    }
  }

  Future<void> getCarServiceById(int carSerId) async {
    setBusy();
    var res = await carsRepo.getCarServiceById(carServiceId: carSerId);
    if (res.left != null) {
      failure = res.left?.message;
      DialogsHelper.messageDialog(message: "${res.left?.message}");
      setError();
    } else {
      carServiceModel = res.right;
      if ((carServiceModel?.images ?? []).isNotEmpty) {
        selectedImageIndex = 0;
      }
      setIdle();
    }
  }
}
