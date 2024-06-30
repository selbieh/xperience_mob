import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/config/size_config.dart';
import 'package:xperience/model/data/repo/hotels_service_repo.dart';
import 'package:xperience/model/services/auth/auth_service.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/screens/auth/login_screen.dart';
import 'package:xperience/view/screens/home/Ultimate/ultimate_step_2_cars.dart';
import 'package:xperience/view/screens/home/car/complete_info_screen.dart';
import 'package:xperience/view/widgets/components/horizental_stepper.dart';
import 'package:xperience/view/widgets/components/main_progress.dart';
import 'package:xperience/view/widgets/custom_button.dart';
import 'package:xperience/view/widgets/dialogs/dialogs_helper.dart';
import 'package:xperience/view/widgets/ultimate_hotel_service_item_widget.dart';

class UltimateStep1HotelScreen extends StatelessWidget {
  const UltimateStep1HotelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<UltimateStep1HotelViewModel>(
      model: UltimateStep1HotelViewModel(
        auth: Provider.of<AuthService>(context),
        hotelsRepo: Provider.of<HotelsServiceRepo>(context),
      ),
      initState: (model) {
        model.initScrollController();
        if ((model.hotelsRepo.hotelsServicesPaginated?.results ?? []).isEmpty) {
          model.getHotelsServices();
        }
      },
      builder: (_, model, child) {
        return Scaffold(
          backgroundColor: AppColors.primaryColorDark,
          appBar: AppBar(
            title: Text("Ultimate Experience".localize(context)),
            backgroundColor: AppColors.primaryColorDark,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: HorizentalStepper(
                  width: 0.80.w,
                  stepsTitleList: const [
                    "CHOOSE \nPROPERTY",
                    "CHOOSE \nYOUR RIDE",
                    "REVIEW & \nCONFIRM",
                  ],
                  currentStep: "CHOOSE \nPROPERTY",
                ),
              ),
              // const Expanded(
              //   child: Column(
              //     children: [
              //       Text("data"),
              //     ],
              //   ),
              // ),
              const SizedBox(height: 20),
              Expanded(
                child: RefreshIndicator(
                  color: AppColors.goldColor,
                  onRefresh: model.refreshHotelServices,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                    controller: model.scrollController,
                    child: Container(
                      child: model.isBusy
                          ? const Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: MainProgress(),
                            )
                          : (model.hotelsRepo.hotelsServicesPaginated?.results ?? []).isEmpty
                              ? Center(
                                  child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
                                  child: Text("No items found".tr()),
                                ))
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: (model.hotelsRepo.hotelsServicesPaginated?.results ?? []).length,
                                  itemBuilder: (ctx, index) {
                                    var item = model.hotelsRepo.hotelsServicesPaginated?.results?[index];
                                    return UltimateHotelServiceItemWidget(
                                      hotelService: item,
                                      groupValue: model.hotelGroupValueId,
                                      onChanged: (_) {
                                        model.hotelGroupValueId = item?.id ?? 0;
                                        model.setState();
                                      },
                                    );
                                  },
                                ),
                    ),
                  ),
                ),
              ),
              if (model.isLoadingMore)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: MainProgress(),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: CustomButton(
                  title: "NEXT".localize(context),
                  onPressed: model.hotelGroupValueId == -1 ? null : model.goToNext,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class UltimateStep1HotelViewModel extends BaseNotifier {
  UltimateStep1HotelViewModel({required this.auth, required this.hotelsRepo});
  final AuthService auth;
  final HotelsServiceRepo hotelsRepo;

  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;

  int hotelGroupValueId = -1;

  Future<void> initScrollController() async {
    scrollController.addListener(() async {
      if (scrollController.position.extentAfter == 0) {
        if (!isLoadingMore && hotelsRepo.hotelsServicesPaginated?.next != null) {
          await getHotelsServices();
        }
      }
    });
  }

  void goToNext() {
    if (auth.isLogged) {
      if ((auth.userModel?.user?.email ?? "") == "") {
        NavService().pushKey(const CompleteInfoScreen()).then((value) => setState());
      } else {
        NavService().pushKey(UltimateStep2CarScreen(hotelServiceId: hotelGroupValueId));
      }
    } else {
      NavService().pushKey(const LoginScreen());
    }
  }

  Future<void> refreshHotelServices() async {
    hotelsRepo.hotelsServicesPaginated = null;
    await getHotelsServices();
  }

  Future<void> getHotelsServices() async {
    if (hotelsRepo.hotelsServicesPaginated == null) {
      setBusy();
    } else {
      isLoadingMore = true;
      setState();
    }
    var res = await hotelsRepo.getHotelsServices();
    if (res.left != null) {
      isLoadingMore = false;
      failure = res.left?.message;
      DialogsHelper.messageDialog(message: "${res.left?.message}");
      setError();
    } else {
      isLoadingMore = false;
      setIdle();
    }
  }
}
