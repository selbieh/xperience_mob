// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/config/logger.dart';
import 'package:xperience/model/data/repo/cars_service_repo.dart';
import 'package:xperience/model/data/repo/hotels_service_repo.dart';
import 'package:xperience/model/models/pagination_model.dart';
import 'package:xperience/model/models/reservation_booking_model.dart';
import 'package:xperience/model/models/service_options_model.dart';
import 'package:xperience/model/services/app_helper.dart';
import 'package:xperience/model/services/auth/auth_service.dart';
import 'package:xperience/model/services/format_helper.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/picker_helper.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/screens/home/payment/payment_screen.dart';
import 'package:xperience/view/screens/home/payment/success_screen.dart';
import 'package:xperience/view/widgets/components/main_button.dart';
import 'package:xperience/view/widgets/components/main_progress.dart';
import 'package:xperience/view/widgets/components/main_textfield.dart';
import 'package:xperience/view/widgets/components/main_textfield_dropdown.dart';
import 'package:xperience/view/widgets/custom_button.dart';
import 'package:xperience/view/widgets/dialogs/dialogs_helper.dart';

class HotelBookingScreen extends StatelessWidget {
  const HotelBookingScreen({
    required this.hotelSerId,
    Key? key,
  }) : super(key: key);

  final int hotelSerId;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<HotelBookingViewModel>(
      model: HotelBookingViewModel(
        context: context,
        auth: Provider.of<AuthService>(context),
        carsRepo: Provider.of<CarsServiceRepo>(context),
        hotelRepo: Provider.of<HotelsServiceRepo>(context),
        hotelServiceId: hotelSerId,
      ),
      initState: (model) {
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
                              "in-room scent",
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
                          const SizedBox(height: 20),
                          MainTextFieldDropdown<String>(
                            hint: "Payment method".localize(context),
                            items: [
                              "CREDIT_CARD",
                              "WALLET",
                              "CASH_ON_DELIVERY",
                              "CAR_POS",
                              "POINTS",
                            ].map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(AppHelper.getPaymentMethod(item.localize(context))),
                              );
                            }).toList(),
                            onChanged: (value) {
                              model.selectedPaymentMethod = value;
                              Logger.log("selectedPaymentMethod: ${model.selectedPaymentMethod}");
                            },
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

class HotelBookingViewModel extends BaseNotifier {
  HotelBookingViewModel({
    required this.context,
    required this.auth,
    required this.carsRepo,
    required this.hotelRepo,
    required this.hotelServiceId,
  });
  final BuildContext context;
  final AuthService auth;
  final CarsServiceRepo carsRepo;
  final HotelsServiceRepo hotelRepo;
  final int hotelServiceId;

  final formKey = GlobalKey<FormState>();
  var autovalidateMode = AutovalidateMode.disabled;
  PaginationModel<ServiceOptionsModel>? serviceOptions;
  List<ServiceOptionsModel> optionsExtras = [];
  List<ServiceOptionsModel> optionsBeverages = [];
  List<ServiceOptionsModel> optionsScent = [];
  List<ServiceOptionsModel> optionsSnacks = [];
  int selectedBaveragesGroupValue = 0;
  int selectedScentGroupValue = 0;
  int selectedSnacksGroupValue = 0;
  final extrasController = TextEditingController();
  final checkInOutController = TextEditingController();
  DateTimeRange? checkInOutRange;
  String? selectedPaymentMethod;

  void submitFun() {
    if (formKey.currentState!.validate()) {
      bookingHotelService();
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
    checkInOutRange = null;
    checkInOutController.clear();
    extrasController.clear();
    setState();
  }

  Future<void> selectCheckInOutDate(BuildContext context) async {
    DateTimeRange? dateTimeRange = await PickerHelper.getDateRangePicker(
      context,
      firstDate: DateTime.now(),
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

  Future<void> getServiceOptions() async {
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

  Map<String, dynamic> generateHotelBookingBody() {
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
          "extras": extrasController.text,
          "options": optionsList,
        }
      ],
      "payment_method": selectedPaymentMethod,
    };
    Logger.printObject(bookingBody);
    return bookingBody;
  }

  bool bookingLoading = false;
  ReservationBookingModel? reservationBookingModel;

  Future<void> bookingHotelService() async {
    try {
      bookingLoading = true;
      setState();
      var res = await hotelRepo.bookingHotelService(
        body: generateHotelBookingBody(),
      );
      bookingLoading = false;
      if (res.left != null) {
        failure = res.left?.message;
        DialogsHelper.messageDialog(message: "${res.left?.message}");
        setError();
      } else {
        reservationBookingModel = res.right;
        if (selectedPaymentMethod == "Credit card") {
          getPaymentURL(reservationBookingModel?.id);
        } else {
          setIdle();
          NavService().pushAndRemoveUntilKey(SuccessScreen(
            isSuccess: true,
            message: "Reservation completed successfully".localize(context),
          ));
        }
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
