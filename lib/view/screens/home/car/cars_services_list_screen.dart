import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/data/repo/cars_service_repo.dart';
import 'package:xperience/model/models/car_make_model.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/screens/home/car/car_details_screen.dart';
import 'package:xperience/view/widgets/car_experience_item_widget.dart';
import 'package:xperience/view/widgets/components/main_button.dart';
import 'package:xperience/view/widgets/components/main_progress.dart';
import 'package:xperience/view/widgets/components/main_textfield.dart';
import 'package:xperience/view/widgets/components/main_textfield_dropdown.dart';
import 'package:xperience/view/widgets/dialogs/dialogs_helper.dart';

class CarsServicesListScreen extends StatelessWidget {
  const CarsServicesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<CarsServicesListViewModel>(
      model: CarsServicesListViewModel(
        carsRepo: Provider.of<CarsServiceRepo>(context),
      ),
      initState: (model) {
        model.initScrollController();
        if ((model.carsRepo.carsServicesPaginated?.results ?? []).isEmpty) {
          model.getCarServices();
        }
        if ((model.carsRepo.carMakesPaginated?.results ?? []).isEmpty) {
          model.getCarMakes();
        }
        if ((model.carsRepo.carModelsPaginated?.results ?? []).isEmpty) {
          model.getCarModels();
        }
      },
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primaryColorDark,
            title: const Text("Car Experience").localize(context),
            actions: [
              MainButton(
                type: ButtonType.text,
                title: "Reset".localize(context),
                color: AppColors.goldColor,
                // onPressed: model.resetFilter,
                onPressed: model.selectedMake != null || model.selectedModel != null || model.searchController.text != "" ? model.resetFilter : null,
              )
            ],
          ),
          body: RefreshIndicator(
            color: AppColors.goldColor,
            onRefresh: model.refreshCarServices,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                controller: model.scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MainTextField(
                      controller: model.searchController,
                      hint: "Search".localize(context),
                      hintStyle: const TextStyle(fontSize: 14, color: AppColors.white),
                      borderRadius: 5,
                      borderWidth: 0.5,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset("assets/svgs/ic_search_2.svg"),
                      ),
                      textInputAction: TextInputAction.search,
                      onFieldSubmitted: (_) {
                        model.refreshCarServices();
                      },
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      children: [
                        SvgPicture.asset("assets/svgs/ic_filters.svg"),
                        const SizedBox(width: 10),
                        const Text(
                          "Filters",
                          style: TextStyle(color: AppColors.greyText),
                        ).localize(context),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MainTextFieldDropdown<CarMakeModel>(
                            items: (model.carsRepo.carMakesPaginated?.results ?? [])
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e.name ?? ""),
                                  ),
                                )
                                .toList(),
                            hint: "Brand".localize(context),
                            icon: const Icon(Icons.arrow_drop_down),
                            style: const TextStyle(fontSize: 14, color: AppColors.white),
                            hintStyle: const TextStyle(fontSize: 14, color: AppColors.white),
                            borderWidth: 0.5,
                            menuMaxHeight: 300,
                            value: model.selectedMake,
                            onChanged: (value) {
                              model.selectedMake = value;
                              model.refreshCarServices();
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: MainTextFieldDropdown<CarMakeModel>(
                            items: (model.carsRepo.carModelsPaginated?.results ?? [])
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e.name ?? ""),
                                  ),
                                )
                                .toList(),
                            hint: "Model".localize(context),
                            icon: const Icon(Icons.arrow_drop_down),
                            style: const TextStyle(fontSize: 14, color: AppColors.white),
                            hintStyle: const TextStyle(fontSize: 14, color: AppColors.white),
                            borderWidth: 0.5,
                            menuMaxHeight: 300,
                            value: model.selectedModel,
                            onChanged: (value) {
                              model.selectedModel = value;
                              model.refreshCarServices();
                            },
                          ),
                        ),
                      ],
                    ),
                    model.isBusy
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
                              return CarExperienceItemWidget(
                                carService: item,
                                onPressed: () {
                                  NavService().pushKey(CarDetailsScreen(carService: item));
                                },
                              );
                            },
                          ),
                    if (model.isLoadingMore)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: MainProgress(),
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

class CarsServicesListViewModel extends BaseNotifier {
  CarsServicesListViewModel({required this.carsRepo});
  final CarsServiceRepo carsRepo;

  final searchController = TextEditingController();
  CarMakeModel? selectedMake;
  CarMakeModel? selectedModel;

  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;

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

  void resetFilter() {
    if (selectedMake != null || selectedModel != null || searchController.text != "") {
      selectedMake = null;
      selectedModel = null;
      searchController.clear();
      refreshCarServices();
    }
  }

  Future<void> getCarServices() async {
    if (carsRepo.carsServicesPaginated == null) {
      setBusy();
    } else {
      isLoadingMore = true;
      setState();
    }
    Map<String, String> filterData = {};
    if (searchController.text.isNotEmpty) {
      filterData.addAll({"search": searchController.text});
    }
    if (selectedMake != null) {
      filterData.addAll({"make": "${selectedMake?.id}"});
    }
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

  Future<void> getCarMakes() async {
    var res = await carsRepo.getCarMakes(
      queryParams: {
        "offset": "0",
        "limit": "1000",
      },
    );
    if (res.left != null) {
      isLoadingMore = false;
      failure = res.left?.message;
      DialogsHelper.messageDialog(message: "${res.left?.message}");
      setError();
    } else {
      setIdle();
    }
  }

  Future<void> getCarModels() async {
    var res = await carsRepo.getCarModels(
      queryParams: {
        "offset": "0",
        "limit": "1000",
      },
    );
    if (res.left != null) {
      isLoadingMore = false;
      failure = res.left?.message;
      DialogsHelper.messageDialog(message: "${res.left?.message}");
      setError();
    } else {
      setIdle();
    }
  }
}
