// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/config/logger.dart';
import 'package:xperience/model/config/size_config.dart';
import 'package:xperience/model/data/repo/cars_service_repo.dart';
import 'package:xperience/model/models/pagination_model.dart';
import 'package:xperience/model/models/reservation_booking_model.dart';
import 'package:xperience/model/models/service_options_model.dart';
import 'package:xperience/model/models/subscription_option_model.dart';
import 'package:xperience/model/services/auth/auth_service.dart';
import 'package:xperience/model/services/format_helper.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/picker_helper.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/router/route_names.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/widgets/components/horizental_stepper.dart';
import 'package:xperience/view/widgets/components/main_button.dart';
import 'package:xperience/view/widgets/components/main_progress.dart';
import 'package:xperience/view/widgets/components/main_textfield.dart';
import 'package:xperience/view/widgets/custom_button.dart';
import 'package:xperience/view/widgets/dashed_line_painter.dart';
import 'package:xperience/view/widgets/dialogs/dialogs_helper.dart';

class UltimateStep3BookingScreen extends StatelessWidget {
  const UltimateStep3BookingScreen({
    required this.carServiceId,
    required this.hotelServiceId,
    Key? key,
  }) : super(key: key);

  final int carServiceId;
  final int hotelServiceId;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<CarBookingViewModel>(
      model: CarBookingViewModel(
        context: context,
        auth: Provider.of<AuthService>(context),
        carsRepo: Provider.of<CarsServiceRepo>(context),
        carServiceId: carServiceId,
        hotelServiceId: hotelServiceId,
        planType: "RIDE",
      ),
      initState: (model) {
        model.initFun();
      },
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Ultimate Experience").localize(context),
            backgroundColor: AppColors.primaryColorDark,
            actions: [
              MainButton(
                type: ButtonType.text,
                title: "Reset",
                color: AppColors.goldColor,
                onPressed: () {
                  model.resetForm();
                },
              )
            ],
          ),
          body: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: model.formKey,
              autovalidateMode: model.autovalidateMode,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Center(
                      child: HorizentalStepper(
                        width: 0.80.w,
                        stepsTitleList: const [
                          "CHOOSE \nPROPERTY",
                          "CHOOSE \nYOUR RIDE",
                          "REVIEW & \nCONFIRM",
                        ],
                        currentStep: "REVIEW & \nCONFIRM",
                      ),
                    ),
                    model.isBusy
                        ? const Padding(
                            padding: EdgeInsets.all(20),
                            child: MainProgress(),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ================================================================================================================================
                              // ================================================================================================================================ Hotel Booking
                              // ================================================================================================================================
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20),
                                  MainTextField(
                                    controller: model.checkInOutController,
                                    hint: "Check-in date - Check-out date".localize(context),
                                    hintStyle: const TextStyle(fontSize: 14, color: AppColors.white),
                                    isReadOnly: true,
                                    borderWidth: 0.5,
                                    validator: Validator.required,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(14),
                                      child: SvgPicture.asset("assets/svgs/ic_calendar_fill.svg"),
                                    ),
                                    onTap: () => model.selectCheckInOutDate(context),
                                  ),
                                  // =============================================================================================== Extras
                                  if (model.hotelOptionsExtras.isNotEmpty) ...[
                                    const SizedBox(height: 20),
                                    const Text(
                                      "Extras",
                                      style: TextStyle(color: AppColors.grey),
                                    ).localize(context),
                                    Column(
                                      children: List.generate(
                                        model.hotelOptionsExtras.length,
                                        (index) {
                                          return ListTile(
                                            dense: true,
                                            contentPadding: const EdgeInsets.all(0),
                                            leading: Checkbox(
                                              value: model.hotelOptionsExtras[index].isSelected ?? false,
                                              onChanged: (value) {
                                                if (value == false) {
                                                  model.hotelOptionsExtras[index].count = 0;
                                                } else {
                                                  model.hotelOptionsExtras[index].count = 1;
                                                }
                                                model.hotelOptionsExtras[index].isSelected = value ?? false;
                                                model.setState();
                                              },
                                            ),
                                            title: Text(
                                              // "Meet & Greet",
                                              model.hotelOptionsExtras[index].name ?? "",
                                              style: const TextStyle(fontSize: 14),
                                              maxLines: 2,
                                            ),
                                            trailing: model.hotelOptionsExtras[index].isSelected != true
                                                ? null
                                                : Wrap(
                                                    crossAxisAlignment: WrapCrossAlignment.center,
                                                    children: [
                                                      IconButton(
                                                        icon: const Icon(Icons.remove),
                                                        onPressed: () {
                                                          if ((model.hotelOptionsExtras[index].count ?? 0) > 0) {
                                                            model.hotelOptionsExtras[index].count = (model.hotelOptionsExtras[index].count ?? 0) - 1;
                                                            if ((model.hotelOptionsExtras[index].count ?? 0) == 0) {
                                                              model.hotelOptionsExtras[index].isSelected = false;
                                                            }
                                                            model.setState();
                                                          }
                                                        },
                                                      ),
                                                      Text("${model.hotelOptionsExtras[index].count}", style: const TextStyle(fontSize: 16)),
                                                      IconButton(
                                                        icon: const Icon(Icons.add),
                                                        onPressed: () {
                                                          if ((model.hotelOptionsExtras[index].count ?? 0) < 8) {
                                                            model.hotelOptionsExtras[index].count = (model.hotelOptionsExtras[index].count ?? 0) + 1;
                                                            model.setState();
                                                          }
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                  // =============================================================================================== Baverages
                                  if (model.hotelOptionsBeverages.isNotEmpty) ...[
                                    const SizedBox(height: 20),
                                    const Text(
                                      "Baverages",
                                      style: TextStyle(color: AppColors.grey),
                                    ).localize(context),
                                    Column(
                                      children: List.generate(
                                        model.hotelOptionsBeverages.length,
                                        (index) {
                                          return ListTile(
                                            dense: true,
                                            contentPadding: const EdgeInsets.all(0),
                                            leading: Radio(
                                              value: model.hotelOptionsBeverages[index].id,
                                              groupValue: model.selectedHotelBaveragesGroupValue,
                                              onChanged: (value) {
                                                model.selectedHotelBaveragesGroupValue = value ?? 0;
                                                model.setState();
                                              },
                                            ),
                                            title: Text(
                                              model.hotelOptionsBeverages[index].name ?? "",
                                              style: const TextStyle(fontSize: 14),
                                              maxLines: 2,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                  // =============================================================================================== Scent Service
                                  if (model.hotelOptionsScent.isNotEmpty) ...[
                                    const SizedBox(height: 20),
                                    const Text(
                                      "Scent Service",
                                      style: TextStyle(color: AppColors.grey),
                                    ).localize(context),
                                    Column(
                                      children: List.generate(
                                        model.hotelOptionsScent.length,
                                        (index) {
                                          return ListTile(
                                            dense: true,
                                            contentPadding: const EdgeInsets.all(0),
                                            leading: Radio(
                                              value: model.hotelOptionsScent[index].id,
                                              groupValue: model.selectedHotelScentGroupValue,
                                              onChanged: (value) {
                                                model.selectedHotelScentGroupValue = value ?? 0;
                                                model.setState();
                                              },
                                            ),
                                            title: Text(
                                              model.hotelOptionsScent[index].name ?? "",
                                              style: const TextStyle(fontSize: 14),
                                              maxLines: 2,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                  // =============================================================================================== Snacks
                                  if (model.hotelOptionsSnacks.isNotEmpty) ...[
                                    const SizedBox(height: 20),
                                    const Text(
                                      "Snacks",
                                      style: TextStyle(color: AppColors.grey),
                                    ).localize(context),
                                    Column(
                                      children: List.generate(
                                        model.hotelOptionsSnacks.length,
                                        (index) {
                                          return ListTile(
                                            dense: true,
                                            contentPadding: const EdgeInsets.all(0),
                                            leading: Radio(
                                              value: model.hotelOptionsSnacks[index].id,
                                              groupValue: model.selectedHotelSnacksGroupValue,
                                              onChanged: (value) {
                                                model.selectedHotelSnacksGroupValue = value ?? 0;
                                                model.setState();
                                              },
                                            ),
                                            title: Text(
                                              model.hotelOptionsSnacks[index].name ?? "",
                                              style: const TextStyle(fontSize: 14),
                                              maxLines: 2,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                  const SizedBox(height: 20),
                                  const Text(
                                    "Extras",
                                    style: TextStyle(color: AppColors.grey),
                                  ).localize(context),
                                  const SizedBox(height: 10),
                                  MainTextField(
                                    controller: model.hotelExtrasController,
                                    keyboardType: TextInputType.multiline,
                                    textInputAction: TextInputAction.newline,
                                    hint: "Please add whatever you want here".localize(context),
                                    borderWidth: 0.5,
                                    maxLines: 5,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              // ================================================================================================================================
                              // ================================================================================================================================ Car Booking
                              // ================================================================================================================================
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey, width: 0.5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.circle_outlined,
                                              size: 14,
                                              color: AppColors.grey,
                                            ),
                                            CustomPaint(
                                              size: const Size(0, 85),
                                              painter: DashedLinePainter(
                                                isDashed: true,
                                                color: AppColors.grey,
                                                dashSpace: 1,
                                                strokeWidth: 0.5,
                                              ),
                                            ),
                                            const Icon(
                                              Icons.circle_outlined,
                                              size: 14,
                                              color: AppColors.grey,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Pick-Up Location",
                                                style: TextStyle(color: AppColors.grey),
                                              ).localize(context),
                                              MainTextField(
                                                controller: model.pickUpDateController,
                                                validator: Validator.required,
                                                hint: "Pick-Up Location".localize(context),
                                                hintStyle: const TextStyle(fontSize: 14, color: AppColors.white),
                                                isReadOnly: true,
                                                borderWidth: 0.5,
                                                onTap: () async {
                                                  LatLng? latLng = await PickerHelper.getLocationPicker(context, targetLatLng: model.pickupLatLng);
                                                  if (latLng != null) {
                                                    model.pickupLatLng = latLng;
                                                    model.pickUpDateController.text = "Change pickup location".tr();
                                                  }
                                                },
                                              ),
                                              const SizedBox(height: 10),
                                              const Text(
                                                "Drop-off Location",
                                                style: TextStyle(color: AppColors.grey),
                                              ).localize(context),
                                              MainTextField(
                                                controller: model.dropOffLocationController,
                                                validator: Validator.required,
                                                hint: "Drop-off Location".localize(context),
                                                hintStyle: const TextStyle(fontSize: 14, color: AppColors.white),
                                                isReadOnly: true,
                                                borderWidth: 0.5,
                                                onTap: () async {
                                                  LatLng? latLng = await PickerHelper.getLocationPicker(context, targetLatLng: model.dropOffLatLng);
                                                  if (latLng != null) {
                                                    model.dropOffLatLng = latLng;
                                                    model.dropOffLocationController.text = "Change drop off location".tr();
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if ((model.subscriptionOptions?.results ?? []).isNotEmpty) ...[
                                    const SizedBox(height: 20),
                                    const Text(
                                      "Ride Duration",
                                      style: TextStyle(color: AppColors.grey),
                                    ).localize(context),
                                    const SizedBox(height: 10),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        // children: [
                                        //   SubscriptionOptionModel(id: 1, durationHours: 2),
                                        //   SubscriptionOptionModel(id: 2, durationHours: 4),
                                        //   SubscriptionOptionModel(id: 3, durationHours: 6),
                                        // ].map((e) {
                                        children: (model.subscriptionOptions?.results ?? []).map((e) {
                                          bool isSelected = model.selectedSubscription?.id == e.id;
                                          return InkWell(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Container(
                                              margin: const EdgeInsets.symmetric(horizontal: 5),
                                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                                              decoration: BoxDecoration(
                                                color: isSelected ? AppColors.selectedColor : null,
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(color: AppColors.grey, width: 0.5),
                                              ),
                                              child: Text(
                                                "${e.durationHours ?? "-"} ${"Hours".localize(context)}",
                                                style: const TextStyle(fontSize: 12),
                                              ),
                                            ),
                                            onTap: () {
                                              if (e != model.selectedSubscription) {
                                                model.selectedSubscription = e;
                                              } else {
                                                model.selectedSubscription = null;
                                              }
                                              model.setState();
                                            },
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                  const SizedBox(height: 20),
                                  // =============================================================================================== Pick-Up Time
                                  const Text(
                                    "Pick-Up Time",
                                    style: TextStyle(color: AppColors.grey),
                                  ).localize(context),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: MainTextField(
                                          controller: model.pickUpDateController,
                                          validator: Validator.required,
                                          hint: "Date".localize(context),
                                          hintStyle: const TextStyle(fontSize: 14, color: AppColors.white),
                                          isReadOnly: true,
                                          borderWidth: 0.5,
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.all(14),
                                            child: SvgPicture.asset("assets/svgs/ic_calendar.svg"),
                                          ),
                                          onTap: () => model.selectDate(context),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: MainTextField(
                                          controller: model.pickUpTimeController,
                                          validator: Validator.required,
                                          hint: "Time".localize(context),
                                          hintStyle: const TextStyle(fontSize: 14, color: AppColors.white),
                                          isReadOnly: true,
                                          borderWidth: 0.5,
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.all(14),
                                            child: SvgPicture.asset("assets/svgs/ic_time.svg"),
                                          ),
                                          onTap: () => model.selectTime(context),
                                        ),
                                      ),
                                    ],
                                  ),

                                  // =============================================================================================== Extras
                                  if (model.carOptionsExtras.isNotEmpty) ...[
                                    const SizedBox(height: 20),
                                    const Text(
                                      "Extras",
                                      style: TextStyle(color: AppColors.grey),
                                    ).localize(context),
                                    Column(
                                      children: List.generate(
                                        model.carOptionsExtras.length,
                                        (index) {
                                          return ListTile(
                                            dense: true,
                                            contentPadding: const EdgeInsets.all(0),
                                            leading: Checkbox(
                                              value: model.carOptionsExtras[index].isSelected ?? false,
                                              onChanged: (value) {
                                                if (value == false) {
                                                  model.carOptionsExtras[index].count = 0;
                                                } else {
                                                  model.carOptionsExtras[index].count = 1;
                                                }
                                                model.carOptionsExtras[index].isSelected = value ?? false;
                                                model.setState();
                                              },
                                            ),
                                            title: Text(
                                              // "Meet & Greet",
                                              model.carOptionsExtras[index].name ?? "",
                                              style: const TextStyle(fontSize: 14),
                                              maxLines: 2,
                                            ),
                                            trailing: model.carOptionsExtras[index].isSelected != true
                                                ? null
                                                : Wrap(
                                                    crossAxisAlignment: WrapCrossAlignment.center,
                                                    children: [
                                                      IconButton(
                                                        icon: const Icon(Icons.remove),
                                                        onPressed: () {
                                                          if ((model.carOptionsExtras[index].count ?? 0) > 0) {
                                                            model.carOptionsExtras[index].count = (model.carOptionsExtras[index].count ?? 0) - 1;
                                                            if ((model.carOptionsExtras[index].count ?? 0) == 0) {
                                                              model.carOptionsExtras[index].isSelected = false;
                                                            }
                                                            model.setState();
                                                          }
                                                        },
                                                      ),
                                                      Text("${model.carOptionsExtras[index].count}", style: const TextStyle(fontSize: 16)),
                                                      IconButton(
                                                        icon: const Icon(Icons.add),
                                                        onPressed: () {
                                                          if ((model.carOptionsExtras[index].count ?? 0) < 8) {
                                                            model.carOptionsExtras[index].count = (model.carOptionsExtras[index].count ?? 0) + 1;
                                                            model.setState();
                                                          }
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                  // =============================================================================================== Baverages
                                  if (model.carOptionsBeverages.isNotEmpty) ...[
                                    const SizedBox(height: 20),
                                    const Text(
                                      "Baverages",
                                      style: TextStyle(color: AppColors.grey),
                                    ).localize(context),
                                    Column(
                                      children: List.generate(
                                        model.carOptionsBeverages.length,
                                        (index) {
                                          return ListTile(
                                            dense: true,
                                            contentPadding: const EdgeInsets.all(0),
                                            leading: Radio(
                                              value: model.carOptionsBeverages[index].id,
                                              groupValue: model.selectedCarBaveragesGroupValue,
                                              onChanged: (value) {
                                                model.selectedCarBaveragesGroupValue = value ?? 0;
                                                model.setState();
                                              },
                                            ),
                                            title: Text(
                                              model.carOptionsBeverages[index].name ?? "",
                                              style: const TextStyle(fontSize: 14),
                                              maxLines: 2,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                  // =============================================================================================== Scent Service
                                  if (model.carOptionsScent.isNotEmpty) ...[
                                    const SizedBox(height: 20),
                                    const Text(
                                      "Scent Service",
                                      style: TextStyle(color: AppColors.grey),
                                    ).localize(context),
                                    Column(
                                      children: List.generate(
                                        model.carOptionsScent.length,
                                        (index) {
                                          return ListTile(
                                            dense: true,
                                            contentPadding: const EdgeInsets.all(0),
                                            leading: Radio(
                                              value: model.carOptionsScent[index].id,
                                              groupValue: model.selectedCarScentGroupValue,
                                              onChanged: (value) {
                                                model.selectedCarScentGroupValue = value ?? 0;
                                                model.setState();
                                              },
                                            ),
                                            title: Text(
                                              model.carOptionsScent[index].name ?? "",
                                              style: const TextStyle(fontSize: 14),
                                              maxLines: 2,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                  // =============================================================================================== Snacks
                                  if (model.carOptionsSnacks.isNotEmpty) ...[
                                    const SizedBox(height: 20),
                                    const Text(
                                      "Snacks",
                                      style: TextStyle(color: AppColors.grey),
                                    ).localize(context),
                                    Column(
                                      children: List.generate(
                                        model.carOptionsSnacks.length,
                                        (index) {
                                          return ListTile(
                                            dense: true,
                                            contentPadding: const EdgeInsets.all(0),
                                            leading: Radio(
                                              value: model.carOptionsSnacks[index].id,
                                              groupValue: model.selectedCarSnacksGroupValue,
                                              onChanged: (value) {
                                                model.selectedCarSnacksGroupValue = value ?? 0;
                                                model.setState();
                                              },
                                            ),
                                            title: Text(
                                              model.carOptionsSnacks[index].name ?? "",
                                              style: const TextStyle(fontSize: 14),
                                              maxLines: 2,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                  // ===============================================================================================
                                  const SizedBox(height: 20),
                                  const Text(
                                    "Extras",
                                    style: TextStyle(color: AppColors.grey),
                                  ).localize(context),
                                  const SizedBox(height: 10),
                                  MainTextField(
                                    controller: model.carExtrasController,
                                    keyboardType: TextInputType.multiline,
                                    textInputAction: TextInputAction.newline,
                                    hint: "Please add whatever you want here".localize(context),
                                    borderWidth: 0.5,
                                    maxLines: 5,
                                  ),
                                  const SizedBox(height: 40),
                                ],
                              ),

                              model.bookingLoading
                                  ? const MainProgress()
                                  : CustomButton(
                                      title: "CONTINUE".localize(context),
                                      onPressed: model.submitFun,
                                    ),
                              const SizedBox(height: 20),
                            ],
                          ),
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

class CarBookingViewModel extends BaseNotifier {
  CarBookingViewModel({
    required this.context,
    required this.auth,
    required this.carsRepo,
    required this.carServiceId,
    required this.hotelServiceId,
    required this.planType,
  });
  final BuildContext context;
  final AuthService auth;
  final CarsServiceRepo carsRepo;
  final int carServiceId;
  final int hotelServiceId;
  final String planType;
  final formKey = GlobalKey<FormState>();
  var autovalidateMode = AutovalidateMode.disabled;

  //========================================================================= Hotel
  PaginationModel<ServiceOptionsModel>? hotelServiceOptions;
  final hotelExtrasController = TextEditingController();
  List<ServiceOptionsModel> hotelOptionsExtras = [];
  List<ServiceOptionsModel> hotelOptionsBeverages = [];
  List<ServiceOptionsModel> hotelOptionsScent = [];
  List<ServiceOptionsModel> hotelOptionsSnacks = [];
  int selectedHotelBaveragesGroupValue = 0;
  int selectedHotelScentGroupValue = 0;
  int selectedHotelSnacksGroupValue = 0;

  //========================================================================= Car
  final pickUpLocationController = TextEditingController();
  final dropOffLocationController = TextEditingController();
  LatLng? pickupLatLng;
  LatLng? dropOffLatLng;
  final pickUpDateController = TextEditingController();
  final pickUpTimeController = TextEditingController();
  final carExtrasController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  SubscriptionOptionModel? selectedSubscription;
  PaginationModel<SubscriptionOptionModel>? subscriptionOptions;
  PaginationModel<ServiceOptionsModel>? carServiceOptions;
  List<ServiceOptionsModel> carOptionsExtras = [];
  List<ServiceOptionsModel> carOptionsBeverages = [];
  List<ServiceOptionsModel> carOptionsScent = [];
  List<ServiceOptionsModel> carOptionsSnacks = [];
  int selectedCarBaveragesGroupValue = 0;
  int selectedCarScentGroupValue = 0;
  int selectedCarSnacksGroupValue = 0;

  void submitFun() {
    if (formKey.currentState!.validate()) {
      ultimateBooking();
    } else {
      autovalidateMode = AutovalidateMode.always;
      setState();
    }
  }

  void resetForm() {
    carOptionsExtras = carOptionsExtras.map((item) {
      item.isSelected = false;
      item.count = 0;
      return item;
    }).toList();
    selectedCarBaveragesGroupValue = 0;
    selectedCarScentGroupValue = 0;
    selectedCarSnacksGroupValue = 0;
    selectedSubscription = null;
    selectedDate = null;
    selectedTime = null;
    pickUpDateController.clear();
    pickUpTimeController.clear();
    pickUpLocationController.clear();
    dropOffLocationController.clear();
    pickupLatLng = null;
    dropOffLatLng = null;
    carExtrasController.clear();
    setState();
  }

  // =================================================================================================================================================
  final checkInOutController = TextEditingController();
  DateTimeRange? checkInOutRange;

  Future<void> selectCheckInOutDate(BuildContext context) async {
    DateTimeRange? dateTimeRange = await PickerHelper.getDateRangePicker(
      context,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (dateTimeRange != null) {
      Logger.log("$dateTimeRange");
      checkInOutRange = dateTimeRange;
      checkInOutController.text = "${FormatHelper.formatDateTime(dateTimeRange.start, pattern: "dd/MM/yyyy")}"
          " - "
          "${FormatHelper.formatDateTime(dateTimeRange.end, pattern: "dd/MM/yyyy")}";
      setState();
    }
  }

  // =================================================================================================================================================

  Future<void> initFun() async {
    Future.wait([
      getHotelServiceOptions(),
      getSubscriptionOptions(),
      getCarServiceOptions(),
    ]);
  }

  Future<void> selectDate(BuildContext context) async {
    final date = await PickerHelper.getDatePicker(
      context,
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      Logger.log("$date");
      selectedDate = date;
      pickUpDateController.text = FormatHelper.formatDateTime(date, pattern: "dd/MM/yyyy");
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final time = await PickerHelper.getTimePicker(
      context,
      initialTime: selectedTime,
    );
    if (time != null) {
      Logger.log("$time");
      selectedTime = time;
      pickUpTimeController.text = FormatHelper.formatTimeOfDay(context, time);
    }
  }

  Future<void> getSubscriptionOptions() async {
    setBusy();
    var res = await carsRepo.getSubscriptionOptions(
      queryParams: {
        "offset": "0",
        "limit": "1000",
        "type": planType,
      },
    );
    if (res.left != null) {
      failure = res.left?.message;
      DialogsHelper.messageDialog(message: "${res.left?.message}");
      setError();
    } else {
      subscriptionOptions = res.right;
      setIdle();
    }
  }

  Future<void> getHotelServiceOptions() async {
    setBusy();
    var res = await carsRepo.getServiceOptions(
      queryParams: {
        "offset": "0",
        "limit": "1000",
        "service_type": "HOTEL",
      },
    );
    if (res.left != null) {
      failure = res.left?.message;
      DialogsHelper.messageDialog(message: "${res.left?.message}");
      setError();
    } else {
      hotelServiceOptions = res.right;
      for (var item in (hotelServiceOptions?.results ?? <ServiceOptionsModel>[])) {
        if (item.type == "Extras") {
          hotelOptionsExtras.add(item);
        } else if (item.type == "Beverages") {
          hotelOptionsBeverages.add(item);
        } else if (item.type == "Snacks") {
          hotelOptionsSnacks.add(item);
        } else if (item.type == "Scent Service") {
          hotelOptionsScent.add(item);
        }
      }
      setIdle();
    }
  }

  Future<void> getCarServiceOptions() async {
    setBusy();
    var res = await carsRepo.getServiceOptions(
      queryParams: {
        "offset": "0",
        "limit": "1000",
        "service_type": "Car",
      },
    );
    if (res.left != null) {
      failure = res.left?.message;
      DialogsHelper.messageDialog(message: "${res.left?.message}");
      setError();
    } else {
      carServiceOptions = res.right;
      for (var item in (carServiceOptions?.results ?? <ServiceOptionsModel>[])) {
        if (item.type == "Extras") {
          carOptionsExtras.add(item);
        } else if (item.type == "Beverages") {
          carOptionsBeverages.add(item);
        } else if (item.type == "Snacks") {
          carOptionsSnacks.add(item);
        } else if (item.type == "Scent Service") {
          carOptionsScent.add(item);
        }
      }
      setIdle();
    }
  }

  Map<String, dynamic> generateUltimateBookingBody() {
    ///=========================================================================== Hotel
    List<Map<String, dynamic>> hotelOptionsList = [];
    for (var option in hotelOptionsExtras) {
      if ((option.count ?? 0) > 0) {
        hotelOptionsList.add({"service_option": option.id, "quantity": option.count});
      }
    }
    if (selectedHotelBaveragesGroupValue != 0) {
      hotelOptionsList.add({"service_option": selectedHotelBaveragesGroupValue, "quantity": 1});
    }
    if (selectedHotelScentGroupValue != 0) {
      hotelOptionsList.add({"service_option": selectedHotelScentGroupValue, "quantity": 1});
    }
    if (selectedHotelSnacksGroupValue != 0) {
      hotelOptionsList.add({"service_option": selectedHotelSnacksGroupValue, "quantity": 1});
    }

    ///=========================================================================== Car
    selectedDate = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );
    List<Map<String, dynamic>> carOptionsList = [];
    for (var option in carOptionsExtras) {
      if ((option.count ?? 0) > 0) {
        carOptionsList.add({"service_option": option.id, "quantity": option.count});
      }
    }
    if (selectedCarBaveragesGroupValue != 0) {
      //  var selectedOption = optionsBeverages.firstWhere((element) => element.id == selectedBaveragesGroupValue) ;
      carOptionsList.add({"service_option": selectedCarBaveragesGroupValue, "quantity": 1});
    }
    if (selectedCarScentGroupValue != 0) {
      carOptionsList.add({"service_option": selectedCarScentGroupValue, "quantity": 1});
    }
    if (selectedCarSnacksGroupValue != 0) {
      carOptionsList.add({"service_option": selectedCarSnacksGroupValue, "quantity": 1});
    }

    Map<String, dynamic> bookingBody = {
      "hotel_reservations": [
        {
          "hotel_service_id": hotelServiceId,
          // "check_in_date": "2023-01-15",
          "check_in_date": FormatHelper.formatDateTime(checkInOutRange!.start, pattern: "yyyy-MM-dd"),
          "check_out_date": FormatHelper.formatDateTime(checkInOutRange!.end, pattern: "yyyy-MM-dd"),
          // "address": "Downtown",
          // "location_lat": 30.0444,
          // "location_long": 31.2357,
          // "location_url": "http://example.com",
          "extras": hotelExtrasController.text,
          "options": hotelOptionsList,
        }
      ],
      "car_reservations": [
        {
          "car_service_id": carServiceId,
          // "pickup_time": "2023-06-15T15:00:00Z",
          "pickup_time": "${selectedDate?.toUtc().toIso8601String()}",
          // "pickup_address": "Giza, 6th of october city",
          // "pickup_lat": 29.970402,
          // "pickup_long": 30.952246,
          // "dropoff_address": "Cairo, tahrir square",
          // "dropoff_lat": 30.044318,
          // "dropoff_long": 31.235752,
          "pickup_address": "test",
          "dropoff_address": "test",
          "pickup_lat": pickupLatLng?.latitude,
          "pickup_long": pickupLatLng?.longitude,
          "dropoff_lat": dropOffLatLng?.latitude,
          "dropoff_long": dropOffLatLng?.longitude,
          // "terminal": "",
          // "flight_number": "",
          "extras": carExtrasController.text,
          "options": carOptionsList,
          "subscription_option": selectedSubscription?.id
        }
      ]
    };
    Logger.printObject(bookingBody);
    return bookingBody;
  }

  bool bookingLoading = false;
  ReservationBookingModel? reservationBookingModel;

  Future<void> ultimateBooking() async {
    try {
      bookingLoading = true;
      setState();
      var res = await carsRepo.bookingCarService(
        body: generateUltimateBookingBody(),
      );
      bookingLoading = false;
      if (res.left != null) {
        failure = res.left?.message;
        DialogsHelper.messageDialog(message: "${res.left?.message}");
        setError();
      } else {
        reservationBookingModel = res.right;
        // NavService().popKey();
        NavService().popUntilKey(settings: const RouteSettings(name: RouteNames.mainScreen));

        setIdle();
      }
    } catch (e) {
      bookingLoading = false;
      failure = e.toString();
      DialogsHelper.messageDialog(message: "$e");
      setError();
    }
  }
}
