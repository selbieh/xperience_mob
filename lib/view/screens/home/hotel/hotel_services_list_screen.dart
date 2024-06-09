import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/config/logger.dart';
import 'package:xperience/model/data/repo/hotels_service_repo.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/picker_helper.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/screens/home/hotel/hotel_details_screen.dart';
import 'package:xperience/view/widgets/components/main_progress.dart';
import 'package:xperience/view/widgets/components/main_textfield.dart';
import 'package:xperience/view/widgets/components/main_textfield_dropdown.dart';
import 'package:xperience/view/widgets/dialogs/dialogs_helper.dart';
import 'package:xperience/view/widgets/hotel_service_item_widget.dart';

class HotelServicesListScreen extends StatelessWidget {
  const HotelServicesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<HotelServicesListViewModel>(
      model: HotelServicesListViewModel(
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
          appBar: AppBar(
            backgroundColor: AppColors.primaryColorDark,
            title: const Text("Hotel Experience").localize(context),
            actions: [
              IconButton(
                icon: SvgPicture.asset("assets/svgs/ic_search.svg"),
                onPressed: () {},
              ),
            ],
          ),
          body: RefreshIndicator(
            color: AppColors.goldColor,
            onRefresh: model.refreshHotelServices,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                controller: model.scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MainTextField(
                      controller: TextEditingController(),
                      hint: "Search".localize(context),
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
                        ).localize(context),
                      ],
                    ),
                    MainTextField(
                      controller: model.checkInOutController,
                      hint: "check-in date - check-out date".localize(context),
                      hintStyle: const TextStyle(fontSize: 14, color: AppColors.white),
                      isReadOnly: true,
                      borderWidth: 0.5,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(14),
                        child: SvgPicture.asset("assets/svgs/ic_calendar_fill.svg"),
                      ),
                      onTap: () => model.selectCheckInOutDate(context),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MainTextFieldDropdown<String>(
                            items: model.locationList
                                .map(
                                  (e) => DropdownMenuItem(value: e, child: Text(e)),
                                )
                                .toList(),
                            hint: "Location".localize(context),
                            icon: const Icon(Icons.arrow_drop_down),
                            style: const TextStyle(fontSize: 14, color: AppColors.white),
                            hintStyle: const TextStyle(fontSize: 14, color: AppColors.white),
                            borderWidth: 0.5,
                            menuMaxHeight: 300,
                            value: model.selectedLocation,
                            onChanged: (value) {
                              model.selectedLocation = value;
                              model.setState();
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: MainTextFieldDropdown<String>(
                            items: model.roomsList
                                .map(
                                  (e) => DropdownMenuItem(value: e, child: Text(e)),
                                )
                                .toList(),
                            hint: "Room facilities".localize(context),
                            icon: const Icon(Icons.arrow_drop_down),
                            style: const TextStyle(fontSize: 14, color: AppColors.white),
                            hintStyle: const TextStyle(fontSize: 14, color: AppColors.white),
                            borderWidth: 0.5,
                            menuMaxHeight: 300,
                            value: model.selectedRoom,
                            onChanged: (value) {
                              model.selectedRoom = value;
                              model.setState();
                            },
                          ),
                        ),
                      ],
                    ),
                    // const SizedBox(height: 10),
                    model.isBusy
                        ? const MainProgress()
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: (model.hotelsRepo.hotelsServicesPaginated?.results ?? []).length,
                            itemBuilder: (ctx, index) {
                              var item = model.hotelsRepo.hotelsServicesPaginated?.results?[index];
                              return HotelServiceItemWidget(
                                hotelService: item,
                                onPressed: () {
                                  NavService().pushKey(const HotelDetailsScreen());
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

class HotelServicesListViewModel extends BaseNotifier {
  HotelServicesListViewModel({required this.hotelsRepo});
  final HotelsServiceRepo hotelsRepo;

  String? selectedLocation;
  String? selectedRoom;
  final checkInOutController = TextEditingController();
  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;

  List<String> locationList = [
    "Cairo",
    "Giza",
    "Alexandria",
    "Sharm El-Sheikh",
  ];
  List<String> roomsList = [
    "Room 1",
    "Room 2",
    "Room 3",
    "Room 4",
    "Room 5",
  ];

  Future<void> initScrollController() async {
    scrollController.addListener(() async {
      if (scrollController.position.extentAfter == 0) {
        if (!isLoadingMore && hotelsRepo.hotelsServicesPaginated?.next != null) {
          await getHotelsServices();
        }
      }
    });
  }

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
