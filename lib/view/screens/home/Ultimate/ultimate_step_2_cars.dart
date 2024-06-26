import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/config/size_config.dart';
import 'package:xperience/model/data/repo/cars_service_repo.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/screens/home/Ultimate/ultimate_step_3_booking.dart';
import 'package:xperience/view/widgets/components/horizental_stepper.dart';
import 'package:xperience/view/widgets/components/main_progress.dart';
import 'package:xperience/view/widgets/custom_button.dart';
import 'package:xperience/view/widgets/dialogs/dialogs_helper.dart';
import 'package:xperience/view/widgets/ultimate_car_service_item_widget.dart';

class UltimateStep2CarScreen extends StatelessWidget {
  const UltimateStep2CarScreen({required this.hotelServiceId, Key? key}) : super(key: key);
  final int hotelServiceId;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<UltimateStep2CarViewModel>(
      model: UltimateStep2CarViewModel(
        carsRepo: Provider.of<CarsServiceRepo>(context),
      ),
      initState: (model) {
        model.initScrollController();
        if ((model.carsRepo.carsServicesPaginated?.results ?? []).isEmpty) {
          model.getCarServices();
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
                  currentStep: "CHOOSE \nYOUR RIDE",
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
                  onRefresh: model.refreshCarServices,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                    controller: model.scrollController,
                    child: Container(
                      child: model.isBusy
                          ? const Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: MainProgress(),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: (model.carsRepo.carsServicesPaginated?.results ?? []).length,
                              itemBuilder: (ctx, index) {
                                var item = model.carsRepo.carsServicesPaginated?.results?[index];
                                return UltimateCarServiceItemWidget(
                                  carService: item,
                                  groupValue: model.carGroupValueId,
                                  onChanged: (_) {
                                    model.carGroupValueId = item?.id ?? 0;
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
                  onPressed: model.carGroupValueId == -1
                      ? null
                      : () {
                          NavService().pushKey(
                            UltimateStep3BookingScreen(
                              carServiceId: model.carGroupValueId,
                              hotelServiceId: hotelServiceId,
                            ),
                          );
                        },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class UltimateStep2CarViewModel extends BaseNotifier {
  UltimateStep2CarViewModel({required this.carsRepo});
  final CarsServiceRepo carsRepo;

  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;
  int carGroupValueId = -1;
  Future<void> initScrollController() async {
    scrollController.addListener(() async {
      if (scrollController.position.extentAfter == 0) {
        if (!isLoadingMore && carsRepo.carsServicesPaginated?.next != null) {
          await getCarServices();
        }
      }
    });
  }

  Future<void> refreshCarServices() async {
    carsRepo.carsServicesPaginated = null;
    await getCarServices();
  }

  Future<void> getCarServices() async {
    if (carsRepo.carsServicesPaginated == null) {
      setBusy();
    } else {
      isLoadingMore = true;
      setState();
    }
    Map<String, String> filterData = {};
    var res = await carsRepo.getCarsServices(queryParams: filterData);
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
