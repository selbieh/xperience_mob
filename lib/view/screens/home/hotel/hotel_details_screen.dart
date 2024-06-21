import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/config/logger.dart';
import 'package:xperience/model/data/repo/hotels_service_repo.dart';
import 'package:xperience/model/models/hotel_service_model.dart';
import 'package:xperience/model/services/auth/auth_service.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/picker_helper.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/screens/home/hotel/hotel_booking_screen.dart';
import 'package:xperience/view/widgets/booknow_button.dart';
import 'package:xperience/view/widgets/components/main_image.dart';
import 'package:xperience/view/widgets/components/main_progress.dart';
import 'package:xperience/view/widgets/components/main_textfield.dart';
import 'package:xperience/view/widgets/dialogs/dialogs_helper.dart';
import 'package:xperience/view/widgets/hotel_feature_border_item.dart';

class HotelDetailsScreen extends StatelessWidget {
  const HotelDetailsScreen({required this.hotelService, Key? key}) : super(key: key);
  final HotelServiceModel? hotelService;

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
          appBar: AppBar(
            title: Text(model.hotelServiceModel?.name ?? ""),
            backgroundColor: AppColors.primaryColorDark,
          ),
          body: model.isBusy
              ? const MainProgress()
              : Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(0),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Column(
                                children: [
                                  MainImage.network(
                                    imagePath: "https://assets.bwbx.io/images/users/iqjWHBFdfxIU/iyix1OYhVxdA/v2/-1x-1.jpg",
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(height: 3),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: MainImage.network(
                                          imagePath: "https://assets.bwbx.io/images/users/iqjWHBFdfxIU/iyix1OYhVxdA/v2/-1x-1.jpg",
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(width: 3),
                                      Expanded(
                                        child: MainImage.network(
                                          imagePath: "https://assets.bwbx.io/images/users/iqjWHBFdfxIU/iyix1OYhVxdA/v2/-1x-1.jpg",
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(width: 3),
                                      Expanded(
                                        child: MainImage.network(
                                          imagePath: "https://assets.bwbx.io/images/users/iqjWHBFdfxIU/iyix1OYhVxdA/v2/-1x-1.jpg",
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
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
                          const SizedBox(height: 20),
                          const Text(
                            "Location",
                            style: TextStyle(fontSize: 16),
                          ).localize(context),
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.grey, width: 0.5),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
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
                                const Text("Choose Check-in Date & Check-out Date").localize(context),
                                const SizedBox(height: 10),
                                MainTextField(
                                  controller: model.checkInOutController,
                                  hint: "Check-in date - Check-out date".localize(context),
                                  hintStyle: const TextStyle(fontSize: 14, color: AppColors.white),
                                  isReadOnly: true,
                                  borderWidth: 0.5,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(14),
                                    child: SvgPicture.asset("assets/svgs/ic_calendar_fill.svg"),
                                  ),
                                  onTap: () => model.selectCheckInOutDate(context),
                                ),
                                const SizedBox(height: 20),
                                Center(
                                  child: BookNowButton(
                                    title: "BOOK PROPERTY".localize(context),
                                    onPressed: () {
                                      NavService().pushKey(HotelBookingScreen(hotelSerId: model.hotelServiceModel?.id ?? -1));
                                    },
                                  ),
                                ),
                                // const SizedBox(height: 20),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
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
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (dateTimeRange != null) {
      Logger.log("$dateTimeRange");
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
      setIdle();
    }
  }
}
