import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/screens/home/car/car_details_screen.dart';
import 'package:xperience/view/widgets/car_experience_item_widget.dart';
import 'package:xperience/view/widgets/components/main_textfield.dart';
import 'package:xperience/view/widgets/components/main_textfield_dropdown.dart';

class CarExperienceScreen extends StatelessWidget {
  const CarExperienceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<CarExperienceViewModel>(
      model: CarExperienceViewModel(),
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primaryColorDark,
            title: const Text("Car Experience"),
            actions: [
              IconButton(
                icon: SvgPicture.asset("assets/svgs/ic_search.svg"),
                onPressed: () {},
              ),
            ],
          ),
          body: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MainTextField(
                    controller: TextEditingController(),
                    hint: "Search",
                    hintStyle: const TextStyle(fontSize: 14, color: AppColors.white),
                    borderRadius: 5,
                    borderWidth: 0.5,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12),
                      child: SvgPicture.asset("assets/svgs/ic_search_2.svg"),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    children: [
                      SvgPicture.asset("assets/svgs/ic_filters.svg"),
                      const SizedBox(width: 10),
                      const Text(
                        "Filters",
                        style: TextStyle(color: AppColors.greyText),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MainTextFieldDropdown<String>(
                          items: model.carBrands
                              .map(
                                (e) => DropdownMenuItem(value: e, child: Text(e)),
                              )
                              .toList(),
                          hint: "Brand",
                          icon: const Icon(Icons.arrow_drop_down),
                          style: const TextStyle(fontSize: 14, color: AppColors.white),
                          hintStyle: const TextStyle(fontSize: 14, color: AppColors.white),
                          borderWidth: 0.5,
                          menuMaxHeight: 300,
                          value: model.selectedCarBrand,
                          onChanged: (value) {
                            model.selectedCarBrand = value;
                            model.setState();
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: MainTextFieldDropdown<String>(
                          items: model.carModels
                              .map(
                                (e) => DropdownMenuItem(value: e, child: Text(e)),
                              )
                              .toList(),
                          hint: "Model",
                          icon: const Icon(Icons.arrow_drop_down),
                          style: const TextStyle(fontSize: 14, color: AppColors.white),
                          hintStyle: const TextStyle(fontSize: 14, color: AppColors.white),
                          borderWidth: 0.5,
                          menuMaxHeight: 300,
                          value: model.selectedCarModel,
                          onChanged: (value) {
                            model.selectedCarModel = value;
                            model.setState();
                          },
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 10),
                  ListView.builder(
                    itemCount: 10,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (ctx, index) {
                      return  CarExperienceItemWidget(onPressed: ()
                      {
                        NavService().pushKey(const CarDetailsScreen());
                      },);
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CarExperienceViewModel extends BaseNotifier {
  String? selectedCarBrand;
  String? selectedCarModel;

  List<String> carBrands = [
    "Toyota",
    "VW",
    "Hyundai",
    "Kia",
    "GM",
    "Ford",
    "Honda",
    "Nissan	",
    "BMW",
    "Mercedes",
    "Renault",
    // "Afsdfds fdsf sdfdsfsdf dsf dsfsdfsdfsd fsdfsdfs ",
    "Suzuki",
    "Tesla",
    "Geely",
  ];
  List<String> carModels = [
    "IONIQ 5 N",
    "KONA Electric",
    "TUCSON",
    "SANTA",
    "KONA Hybrid",
    "i10",
    "i20",
    "New i20",
    "i30",
    "KONA",
    "NEXO",
  ];
}
