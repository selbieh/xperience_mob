// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/config/logger.dart';
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
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/screens/home/payment/payment_screen.dart';
import 'package:xperience/view/widgets/components/main_button.dart';
import 'package:xperience/view/widgets/components/main_progress.dart';
import 'package:xperience/view/widgets/components/main_textfield.dart';
import 'package:xperience/view/widgets/custom_button.dart';
import 'package:xperience/view/widgets/dashed_line_painter.dart';
import 'package:xperience/view/widgets/dialogs/dialogs_helper.dart';

class CarBookingScreen extends StatelessWidget {
  const CarBookingScreen({
    required this.planType,
    required this.carServiceId,
    Key? key,
  }) : super(key: key);

  final String planType;
  final int carServiceId;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<CarBookingViewModel>(
      model: CarBookingViewModel(
        context: context,
        auth: Provider.of<AuthService>(context),
        carsRepo: Provider.of<CarsServiceRepo>(context),
        carServiceId: carServiceId,
        planType: planType,
      ),
      initState: (model) {
        model.getSubscriptionOptions();
        model.getServiceOptions();
      },
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Booking Details").localize(context),
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
          body: model.isBusy
              ? const MainProgress()
              : Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: model.formKey,
                    autovalidateMode: model.autovalidateMode,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
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
                          if (model.optionsExtras.isNotEmpty) ...[
                            const SizedBox(height: 20),
                            const Text(
                              "Extras",
                              style: TextStyle(color: AppColors.grey),
                            ).localize(context),
                            Column(
                              children: List.generate(
                                model.optionsExtras.length,
                                (index) {
                                  return ListTile(
                                    dense: true,
                                    contentPadding: const EdgeInsets.all(0),
                                    leading: Checkbox(
                                      value: model.optionsExtras[index].isSelected ?? false,
                                      onChanged: (value) {
                                        if (value == false) {
                                          model.optionsExtras[index].count = 0;
                                        } else {
                                          model.optionsExtras[index].count = 1;
                                        }
                                        model.optionsExtras[index].isSelected = value ?? false;
                                        model.setState();
                                      },
                                    ),
                                    title: Text(
                                      // "Meet & Greet",
                                      model.optionsExtras[index].name ?? "",
                                      style: const TextStyle(fontSize: 14),
                                      maxLines: 2,
                                    ),
                                    trailing: model.optionsExtras[index].isSelected != true
                                        ? null
                                        : Wrap(
                                            crossAxisAlignment: WrapCrossAlignment.center,
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.remove),
                                                onPressed: () {
                                                  if ((model.optionsExtras[index].count ?? 0) > 0) {
                                                    model.optionsExtras[index].count = (model.optionsExtras[index].count ?? 0) - 1;
                                                    if ((model.optionsExtras[index].count ?? 0) == 0) {
                                                      model.optionsExtras[index].isSelected = false;
                                                    }
                                                    model.setState();
                                                  }
                                                },
                                              ),
                                              Text("${model.optionsExtras[index].count}", style: const TextStyle(fontSize: 16)),
                                              IconButton(
                                                icon: const Icon(Icons.add),
                                                onPressed: () {
                                                  if ((model.optionsExtras[index].count ?? 0) < 8) {
                                                    model.optionsExtras[index].count = (model.optionsExtras[index].count ?? 0) + 1;
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
                          if (model.optionsBeverages.isNotEmpty) ...[
                            const SizedBox(height: 20),
                            const Text(
                              "Baverages",
                              style: TextStyle(color: AppColors.grey),
                            ).localize(context),
                            Column(
                              children: List.generate(
                                model.optionsBeverages.length,
                                (index) {
                                  return ListTile(
                                    dense: true,
                                    contentPadding: const EdgeInsets.all(0),
                                    leading: Radio(
                                      value: model.optionsBeverages[index].id,
                                      groupValue: model.selectedBaveragesGroupValue,
                                      onChanged: (value) {
                                        model.selectedBaveragesGroupValue = value ?? 0;
                                        model.setState();
                                      },
                                    ),
                                    title: Text(
                                      model.optionsBeverages[index].name ?? "",
                                      style: const TextStyle(fontSize: 14),
                                      maxLines: 2,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                          // =============================================================================================== Scent Service
                          if (model.optionsScent.isNotEmpty) ...[
                            const SizedBox(height: 20),
                            const Text(
                              "Scent Service",
                              style: TextStyle(color: AppColors.grey),
                            ).localize(context),
                            Column(
                              children: List.generate(
                                model.optionsScent.length,
                                (index) {
                                  return ListTile(
                                    dense: true,
                                    contentPadding: const EdgeInsets.all(0),
                                    leading: Radio(
                                      value: model.optionsScent[index].id,
                                      groupValue: model.selectedScentGroupValue,
                                      onChanged: (value) {
                                        model.selectedScentGroupValue = value ?? 0;
                                        model.setState();
                                      },
                                    ),
                                    title: Text(
                                      model.optionsScent[index].name ?? "",
                                      style: const TextStyle(fontSize: 14),
                                      maxLines: 2,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                          // =============================================================================================== Snacks
                          if (model.optionsSnacks.isNotEmpty) ...[
                            const SizedBox(height: 20),
                            const Text(
                              "Snacks",
                              style: TextStyle(color: AppColors.grey),
                            ).localize(context),
                            Column(
                              children: List.generate(
                                model.optionsSnacks.length,
                                (index) {
                                  return ListTile(
                                    dense: true,
                                    contentPadding: const EdgeInsets.all(0),
                                    leading: Radio(
                                      value: model.optionsSnacks[index].id,
                                      groupValue: model.selectedSnacksGroupValue,
                                      onChanged: (value) {
                                        model.selectedSnacksGroupValue = value ?? 0;
                                        model.setState();
                                      },
                                    ),
                                    title: Text(
                                      model.optionsSnacks[index].name ?? "",
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
                            controller: model.extrasController,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            hint: "Please add whatever you want here".localize(context),
                            borderWidth: 0.5,
                            maxLines: 5,
                          ),
                          const SizedBox(height: 40),
                          model.bookingLoading
                              ? const MainProgress()
                              : CustomButton(
                                  title: "CONTINUE".localize(context),
                                  onPressed: model.submitFun,
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

class CarBookingViewModel extends BaseNotifier {
  CarBookingViewModel({
    required this.context,
    required this.auth,
    required this.carsRepo,
    required this.carServiceId,
    required this.planType,
  });
  final BuildContext context;
  final AuthService auth;
  final CarsServiceRepo carsRepo;
  final int carServiceId;
  final String planType;

  final formKey = GlobalKey<FormState>();
  var autovalidateMode = AutovalidateMode.disabled;
  final pickUpLocationController = TextEditingController();
  final dropOffLocationController = TextEditingController();
  LatLng? pickupLatLng;
  LatLng? dropOffLatLng;
  final pickUpDateController = TextEditingController();
  final pickUpTimeController = TextEditingController();
  final extrasController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  SubscriptionOptionModel? selectedSubscription;
  PaginationModel<SubscriptionOptionModel>? subscriptionOptions;
  PaginationModel<ServiceOptionsModel>? serviceOptions;
  List<ServiceOptionsModel> optionsExtras = [];
  List<ServiceOptionsModel> optionsBeverages = [];
  List<ServiceOptionsModel> optionsScent = [];
  List<ServiceOptionsModel> optionsSnacks = [];
  int selectedBaveragesGroupValue = 0;
  int selectedScentGroupValue = 0;
  int selectedSnacksGroupValue = 0;

  void submitFun() {
    if (formKey.currentState!.validate()) {
      // generatebookingBody();
      bookingCarService();
    } else {
      autovalidateMode = AutovalidateMode.always;
      setState();
    }
  }

  void resetForm() {
    optionsExtras = optionsExtras.map((item) {
      item.isSelected = false;
      item.count = 0;
      return item;
    }).toList();
    selectedBaveragesGroupValue = 0;
    selectedScentGroupValue = 0;
    selectedSnacksGroupValue = 0;
    selectedSubscription = null;
    selectedDate = null;
    selectedTime = null;
    pickUpDateController.clear();
    pickUpTimeController.clear();
    pickUpLocationController.clear();
    dropOffLocationController.clear();
    pickupLatLng = null;
    dropOffLatLng = null;
    extrasController.clear();
    setState();
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

  Future<void> getServiceOptions() async {
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
      serviceOptions = res.right;
      for (var item in (serviceOptions?.results ?? <ServiceOptionsModel>[])) {
        if (item.type == "Extras") {
          optionsExtras.add(item);
        } else if (item.type == "Beverages") {
          optionsBeverages.add(item);
        } else if (item.type == "Snacks") {
          optionsSnacks.add(item);
        } else if (item.type == "Scent Service") {
          optionsScent.add(item);
        }
      }
      setIdle();
    }
  }

  Map<String, dynamic> generateCarBookingBody() {
    selectedDate = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );
    List<Map<String, dynamic>> optionsList = [];
    for (var option in optionsExtras) {
      if ((option.count ?? 0) > 0) {
        optionsList.add({"service_option": option.id, "quantity": option.count});
      }
    }
    if (selectedBaveragesGroupValue != 0) {
      //  var selectedOption = optionsBeverages.firstWhere((element) => element.id == selectedBaveragesGroupValue) ;
      optionsList.add({"service_option": selectedBaveragesGroupValue, "quantity": 1});
    }
    if (selectedScentGroupValue != 0) {
      optionsList.add({"service_option": selectedScentGroupValue, "quantity": 1});
    }
    if (selectedSnacksGroupValue != 0) {
      optionsList.add({"service_option": selectedSnacksGroupValue, "quantity": 1});
    }

    Map<String, dynamic> bookingBody = {
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
          "extras": extrasController.text,
          "options": optionsList,
          "subscription_option": selectedSubscription?.id
        }
      ]
    };
    Logger.printObject(bookingBody);
    return bookingBody;
  }

  bool bookingLoading = false;
  ReservationBookingModel? reservationBookingModel;

  Future<void> bookingCarService() async {
    try {
      bookingLoading = true;
      setState();
      var res = await carsRepo.bookingCarService(
        body: generateCarBookingBody(),
      );
      bookingLoading = false;
      if (res.left != null) {
        failure = res.left?.message;
        DialogsHelper.messageDialog(message: "${res.left?.message}");
        setError();
      } else {
        reservationBookingModel = res.right;
        // setIdle();
        // NavService().popUntilKey(settings: const RouteSettings(name: RouteNames.mainScreen));
        // AppMessenger.snackBar(
        //   backgroundColor: Colors.green.shade800,
        //   title: "Successfully".tr(),
        //   message: "Your successfully created your booking".tr(),
        // );
        getPaymentURL(reservationBookingModel?.id);
      }
    } catch (e) {
      bookingLoading = false;
      failure = e.toString();
      DialogsHelper.messageDialog(message: "$e");
      setError();
    }
  }

  Future<void> getPaymentURL(int? reservationId) async {
    var res = await carsRepo.getPaymentURL(
      body: {"reservation_id": reservationId},
    );
    if (res.left != null) {
      failure = res.left?.message;
      DialogsHelper.messageDialog(message: "${res.left?.message}");
      setError();
    } else {
      setIdle();
      NavService().pushKey(PaymentScreen(
        paymentUrl: "${res.right}",
        reservationId: reservationId ?? -1,
      ));
    }
  }
}
