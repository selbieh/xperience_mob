// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/config/logger.dart';
import 'package:xperience/model/data/repo/cars_service_repo.dart';
import 'package:xperience/model/models/pagination_model.dart';
import 'package:xperience/model/models/service_options_model.dart';
import 'package:xperience/model/models/subscription_option_model.dart';
import 'package:xperience/model/services/auth/auth_service.dart';
import 'package:xperience/model/services/format_helper.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/picker_helper.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/widgets/components/main_progress.dart';
import 'package:xperience/view/widgets/components/main_textfield.dart';
import 'package:xperience/view/widgets/custom_button.dart';
import 'package:xperience/view/widgets/dashed_line_painter.dart';
import 'package:xperience/view/widgets/dialogs/dialogs_helper.dart';

class CarBookingScreen extends StatelessWidget {
  const CarBookingScreen({
    required this.planType,
    Key? key,
  }) : super(key: key);

  final String planType;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<CarBookingViewModel>(
      model: CarBookingViewModel(
        context: context,
        auth: Provider.of<AuthService>(context),
        carsRepo: Provider.of<CarsServiceRepo>(context),
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
                                        onTap: () {},
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        "Drop-off Location",
                                        style: TextStyle(color: AppColors.grey),
                                      ).localize(context),
                                      MainTextField(
                                        controller: model.pickUpDateController,
                                        validator: Validator.required,
                                        hint: "Drop-off Location".localize(context),
                                        hintStyle: const TextStyle(fontSize: 14, color: AppColors.white),
                                        isReadOnly: true,
                                        borderWidth: 0.5,
                                        onTap: () {},
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
                          CustomButton(
                            title: "CONTINUE".localize(context),
                            // onPressed: model.submitFun,
                            onPressed: model.booking,
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
    required this.planType,
  });
  final BuildContext context;
  final AuthService auth;
  final CarsServiceRepo carsRepo;
  final String planType;

  final formKey = GlobalKey<FormState>();
  var autovalidateMode = AutovalidateMode.disabled;
  final pickUpDateController = TextEditingController();
  final pickUpTimeController = TextEditingController();
  final extrasController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  PaginationModel<SubscriptionOptionModel>? subscriptionOptions;
  PaginationModel<ServiceOptionsModel>? serviceOptions;
  SubscriptionOptionModel? selectedSubscription;

  void submitFun() {
    if (formKey.currentState!.validate()) {
      booking();
    } else {
      autovalidateMode = AutovalidateMode.always;
      setState();
    }
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
        "limit": "100",
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
      setIdle();
    }
  }

  Future<void> booking() async {
    Logger.printt({
      {
        "car_reservations": [
          {
            "car_service_id": 2,
            "pickup_time": "2023-06-15T15:00:00Z",
            "pickup_address": "Giza, 6th of october city",
            "pickup_lat": 29.970402,
            "pickup_long": 30.952246,
            "dropoff_address": "Cairo, tahrir square",
            "dropoff_lat": 30.044318,
            "dropoff_long": 31.235752,
            // "terminal": "",
            // "flight_number": "",
            "extras": extrasController.text,
            "options": [
              {
                "service_option": 1,
                "quantity": 2,
              },
              {
                "service_option": 2,
                "quantity": 2,
              },
            ],
            "subscription_option": selectedSubscription?.id
          }
        ]
      }
    });
  }
}
