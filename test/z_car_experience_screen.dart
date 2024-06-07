// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart' as refresher;
// import 'package:xperience/model/base/base_notifier.dart';
// import 'package:xperience/model/base/base_widget.dart';
// import 'package:xperience/model/data/remote_data_source.dart';
// import 'package:xperience/model/models/car_serv_model.dart';
// import 'package:xperience/model/models/pagination_model.dart';
// import 'package:xperience/model/services/router/nav_service.dart';
// import 'package:xperience/model/services/theme/app_colors.dart';
// import 'package:xperience/view/screens/home/car/car_details_screen.dart';
// import 'package:xperience/view/widgets/car_experience_item_widget.dart';
// import 'package:xperience/view/widgets/components/main_progress.dart';
// import 'package:xperience/view/widgets/components/main_textfield.dart';
// import 'package:xperience/view/widgets/components/main_textfield_dropdown.dart';
// import 'package:xperience/view/widgets/dialogs/dialogs_helper.dart';

// class CarExperienceScreen extends StatelessWidget {
//   const CarExperienceScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BaseWidget<CarExperienceViewModel>(
//       model: CarExperienceViewModel(),
//       initState: (model) {
//         model.getCarServices();
//       },
//       builder: (_, model, child) {
//         return Scaffold(
//           appBar: AppBar(
//             backgroundColor: AppColors.primaryColorDark,
//             title: const Text("Car Experience"),
//             actions: [
//               IconButton(
//                 icon: SvgPicture.asset("assets/svgs/ic_search.svg"),
//                 onPressed: () {
//                   model.carsServicesPaginated = null;
//                   model.getCarServices();
//                 },
//               ),
//             ],
//           ),
//           // body: Container(
//           //   width: double.infinity,
//           //   padding: const EdgeInsets.symmetric(horizontal: 20),
//           body: RefreshIndicator(
//             color: AppColors.goldColor,
//             onRefresh: () async {
//               model.carsServicesPaginated = null;
//               await model.getCarServices();
//               model.refreshController.refreshCompleted();
//             },
//             child: refresher.SmartRefresher(
//               controller: model.refreshController,
//               // enablePullDown: true,
//               enablePullDown: false,
//               enablePullUp: true,
//               onRefresh: () async {
//                 // model.carsServicesPaginated = null;
//                 await model.getCarServices().then((_) {
//                   // model.refreshController.refreshCompleted();
//                   // model.refreshController.refreshToIdle();
//                   model.refreshController.refreshCompleted;
//                 });
//               },
//               onLoading: () async {
//                 if (model.carsServicesPaginated?.next != null) {
//                   await model.getCarServices();
//                   model.refreshController.loadComplete();
//                 } else {
//                   model.refreshController.loadComplete();
//                 }
//               },
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     // mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       MainTextField(
//                         controller: TextEditingController(),
//                         hint: "Search",
//                         hintStyle: const TextStyle(fontSize: 14, color: AppColors.white),
//                         borderRadius: 5,
//                         borderWidth: 0.5,
//                         prefixIcon: Padding(
//                           padding: const EdgeInsets.all(12),
//                           child: SvgPicture.asset("assets/svgs/ic_search_2.svg"),
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       Wrap(
//                         children: [
//                           SvgPicture.asset("assets/svgs/ic_filters.svg"),
//                           const SizedBox(width: 10),
//                           const Text(
//                             "Filters",
//                             style: TextStyle(color: AppColors.greyText),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: MainTextFieldDropdown<String>(
//                               items: model.carBrands
//                                   .map(
//                                     (e) => DropdownMenuItem(value: e, child: Text(e)),
//                                   )
//                                   .toList(),
//                               hint: "Brand",
//                               icon: const Icon(Icons.arrow_drop_down),
//                               style: const TextStyle(fontSize: 14, color: AppColors.white),
//                               hintStyle: const TextStyle(fontSize: 14, color: AppColors.white),
//                               borderWidth: 0.5,
//                               menuMaxHeight: 300,
//                               value: model.selectedCarBrand,
//                               onChanged: (value) {
//                                 model.selectedCarBrand = value;
//                                 model.setState();
//                               },
//                             ),
//                           ),
//                           const SizedBox(width: 10),
//                           Expanded(
//                             child: MainTextFieldDropdown<String>(
//                               items: model.carModels
//                                   .map(
//                                     (e) => DropdownMenuItem(value: e, child: Text(e)),
//                                   )
//                                   .toList(),
//                               hint: "Model",
//                               icon: const Icon(Icons.arrow_drop_down),
//                               style: const TextStyle(fontSize: 14, color: AppColors.white),
//                               hintStyle: const TextStyle(fontSize: 14, color: AppColors.white),
//                               borderWidth: 0.5,
//                               menuMaxHeight: 300,
//                               value: model.selectedCarModel,
//                               onChanged: (value) {
//                                 model.selectedCarModel = value;
//                                 model.setState();
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                       // const SizedBox(height: 10),
//                       model.isBusy
//                           ? const MainProgress()
//                           : ListView.builder(
//                               shrinkWrap: true,
//                               physics: const NeverScrollableScrollPhysics(),
//                               itemCount: model.carsServicesList.length,
//                               itemBuilder: (ctx, index) {
//                                 var item = model.carsServicesList[index];
//                                 return CarExperienceItemWidget(
//                                   carService: item,
//                                   onPressed: () {
//                                     NavService().pushKey(const CarDetailsScreen());
//                                   },
//                                 );
//                               },
//                             ),
//                       const SizedBox(height: 20),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class CarExperienceViewModel extends BaseNotifier {
//   String? selectedCarBrand;
//   String? selectedCarModel;

//   final refreshController = refresher.RefreshController(initialRefresh: false);
//   List<String> carBrands = [
//     "Toyota",
//     "VW",
//     "Hyundai",
//     "Kia",
//     "GM",
//     "Ford",
//     "Honda",
//     "Nissan	",
//     "BMW",
//     "Mercedes",
//     "Renault",
//     // "Afsdfds fdsf sdfdsfsdf dsf dsfsdfsdfsd fsdfsdfs ",
//     "Suzuki",
//     "Tesla",
//     "Geely",
//   ];
//   List<String> carModels = [
//     "IONIQ 5 N",
//     "KONA Electric",
//     "TUCSON",
//     "SANTA",
//     "KONA Hybrid",
//     "i10",
//     "i20",
//     "New i20",
//     "i30",
//     "KONA",
//     "NEXO",
//   ];

//   List<CarServModel> carsServicesList = [];
//   PaginationModel<CarServModel>? carsServicesPaginated;
//   int pageOffset = 0;
//   int pageLimit = 3;

//   Future<void> getCarServices() async {
//     try {
//       if (carsServicesPaginated == null) {
//         pageOffset = 0;
//         carsServicesList.clear();
//         setBusy();
//       } else {
//         pageOffset += pageLimit;
//       }
//       var res = await RemoteDataSource.getCarServices(
//         queryParams: {
//           "offset": "$pageOffset",
//           "limit": "$pageLimit",
//         },
//       );
//       if (res.left != null) {
//         failure = res.left?.message;
//         DialogsHelper.messageDialog(message: "${res.left?.message}");
//         setError();
//       } else {
//         carsServicesPaginated = res.right;
//         if (carsServicesList.isEmpty) {
//           carsServicesList = carsServicesPaginated?.results ?? [];
//         } else {
//           carsServicesList.addAll(carsServicesPaginated?.results ?? []);
//         }
//         setIdle();
//       }
//     } catch (e) {
//       failure = e.toString();
//       setError();
//     }
//   }
// }
