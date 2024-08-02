import 'package:flutter/material.dart';
import 'package:panorama_viewer/panorama_viewer.dart';
import 'package:provider/provider.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/config/logger.dart';
import 'package:xperience/model/config/size_config.dart';
import 'package:xperience/model/data/repo/hotels_service_repo.dart';
import 'package:xperience/model/models/hotel_service_model.dart';
import 'package:xperience/model/services/auth/auth_service.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/picker_helper.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/screens/auth/login_screen.dart';
import 'package:xperience/view/screens/home/car/car_panorama_preview_screen.dart';
import 'package:xperience/view/screens/home/car/complete_info_screen.dart';
import 'package:xperience/view/screens/home/hotel/hotel_booking_screen.dart';
import 'package:xperience/view/widgets/booknow_button.dart';
import 'package:xperience/view/widgets/components/main_progress.dart';
import 'package:xperience/view/widgets/dialogs/dialogs_helper.dart';
import 'package:xperience/view/widgets/hotel_feature_border_item.dart';

class HotelDetailsScreen extends StatelessWidget {
  const HotelDetailsScreen({
    required this.hotelService,
    this.isFromUltimate = false,
    Key? key,
  }) : super(key: key);

  final HotelServiceModel? hotelService;
  final bool isFromUltimate;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<HotelDetailsViewModel>(
      initState: (model) {
        model.getHotelServiceById(hotelService?.id ?? -1);
      },
      model: HotelDetailsViewModel(
        auth: Provider.of<AuthService>(context),
        hotelRepo: Provider.of<HotelsServiceRepo>(context),
      ),
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(title: Text(model.hotelServiceModel?.name ?? "")),
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
                        // const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(width: double.infinity),
                            if (model.selectedImageIndex != -1)
                              InkWell(
                                child: SizedBox(
                                  height: 0.25.h,
                                  width: double.infinity,
                                  child: PanoramaViewer(
                                    child: Image.network(model.hotelServiceModel?.images?[model.selectedImageIndex ?? 0].image ?? ""),
                                  ),
                                ),
                                onTap: () {
                                  NavService().pushKey(
                                    PanoramaPreviewScreen(
                                      imageUrl: model.hotelServiceModel?.images?[model.selectedImageIndex ?? 0].image ?? "",
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
                                        if ((model.selectedImageIndex ?? 0) < (model.hotelServiceModel?.images?.length ?? 0) - 1) {
                                          model.selectedImageIndex = (model.selectedImageIndex ?? 0) + 1;
                                          model.setState();
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            // ==================================================================================================
                            // ==================================================================================================

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20),
                                  Text(
                                    "${model.hotelServiceModel?.dayPrice} ${"EGP".localize(context)}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const Text(
                                    "Per night",
                                    style: TextStyle(color: AppColors.greyText, fontSize: 14),
                                  ).localize(context),
                                  const SizedBox(height: 20),
                                  const Text(
                                    "Features",
                                    style: TextStyle(fontSize: 16),
                                  ).localize(context),
                                  const SizedBox(height: 10),
                                  const SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        HotelFeatureBoarderItem(
                                          icon: "assets/svgs/ic_wifi.svg",
                                          title: "WIFI",
                                        ),
                                        SizedBox(width: 10),
                                        HotelFeatureBoarderItem(
                                          icon: "assets/svgs/ic_sea_view.svg",
                                          title: "Sea View",
                                        ),
                                        SizedBox(width: 10),
                                        HotelFeatureBoarderItem(
                                          icon: "assets/svgs/ic_breakfast.svg",
                                          title: "Breakfast",
                                        ),
                                        SizedBox(width: 10),
                                        HotelFeatureBoarderItem(
                                          icon: "assets/svgs/ic_wifi.svg",
                                          title: "WIFI",
                                        ),
                                        SizedBox(width: 10),
                                        HotelFeatureBoarderItem(
                                          icon: "assets/svgs/ic_sea_view.svg",
                                          title: "Sea View",
                                        ),
                                        SizedBox(width: 10),
                                        HotelFeatureBoarderItem(
                                          icon: "assets/svgs/ic_breakfast.svg",
                                          title: "Breakfast",
                                        ),
                                        SizedBox(width: 10),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // ================================================================================================= Hotel Image Location
                        // const SizedBox(height: 20),
                        // const Text(
                        //   "Location",
                        //   style: TextStyle(fontSize: 16),
                        // ).localize(context),
                        // const SizedBox(height: 20),
                        // Container(
                        //   width: double.infinity,
                        //   height: 150,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(10),
                        //     border: Border.all(color: AppColors.grey, width: 0.5),
                        //   ),
                        // ),
                        // =================================================================================================
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
                              // const Text("Choose Check-in Date & Check-out Date").localize(context),
                              // const SizedBox(height: 10),
                              // MainTextField(
                              //   controller: model.checkInOutController,
                              //   hint: "Check-in date - Check-out date".localize(context),
                              //   hintStyle: const TextStyle(fontSize: 14, color: AppColors.white),
                              //   isReadOnly: true,
                              //   borderWidth: 0.5,
                              //   prefixIcon: Padding(
                              //     padding: const EdgeInsets.all(14),
                              //     child: SvgPicture.asset("assets/svgs/ic_calendar_fill.svg"),
                              //   ),
                              //   onTap: () => model.selectCheckInOutDate(context),
                              // ),
                              const SizedBox(height: 20),
                              if (isFromUltimate == false)
                                Center(
                                  child: BookNowButton(
                                    title: "BOOK PROPERTY".localize(context),
                                    onPressed: model.goToBooking,
                                  ),
                                ),
                              // const SizedBox(height: 20),
                            ],
                          ),
                        ),
                        // const SizedBox(height: 20),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}

class HotelDetailsViewModel extends BaseNotifier {
  HotelDetailsViewModel({required this.auth, required this.hotelRepo});
  final AuthService auth;
  final HotelsServiceRepo hotelRepo;

  int? selectedImageIndex = -1;
  HotelServiceModel? hotelServiceModel;
  String selectedPlan = "RIDE";
  List<String> plansList = [
    "RIDE",
    "TRAVEL",
    "AIRPORT",
  ];

  final checkInOutController = TextEditingController();

  Future<void> selectCheckInOutDate(BuildContext context) async {
    DateTimeRange? dateTimeRange = await PickerHelper.getDateRangePicker(
      context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (dateTimeRange != null) {
      Logger.log("$dateTimeRange");
    }
  }

  void goToBooking() {
    if (auth.isLogged) {
      if ((auth.userModel?.user?.email ?? "") == "") {
        NavService().pushKey(const CompleteInfoScreen()).then((value) => setState());
      } else {
        NavService().pushKey(HotelBookingScreen(hotelSerId: hotelServiceModel?.id ?? -1));
      }
    } else {
      NavService().pushKey(const LoginScreen());
    }
  }

  Future<void> getHotelServiceById(int carSerId) async {
    setBusy();
    var res = await hotelRepo.getHotelServiceById(carServiceId: carSerId);
    if (res.left != null) {
      failure = res.left?.message;
      DialogsHelper.messageDialog(message: "${res.left?.message}");
      setError();
    } else {
      hotelServiceModel = res.right;
      if ((hotelServiceModel?.images ?? []).isNotEmpty) {
        selectedImageIndex = 0;
      }
      setIdle();
    }
  }
}
