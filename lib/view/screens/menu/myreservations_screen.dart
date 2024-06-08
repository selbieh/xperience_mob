import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/data/reservations_service_repo.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/widgets/components/main_progress.dart';
import 'package:xperience/view/widgets/dialogs/dialogs_helper.dart';
import 'package:xperience/view/widgets/reservation_item_widget.dart';

class MyReservationsScreen extends StatelessWidget {
  const MyReservationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<MyReservationsScreenModel>(
      model: MyReservationsScreenModel(
        reservationRepo: Provider.of<ReservationRepo>(context),
      ),
      initState: (model) {
        model.initScrollController();
        if ((model.reservationRepo.reservationsPaginated?.results ?? []).isEmpty) {
          model.getCarServices();
        }
      },
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("My resevations"),
            backgroundColor: AppColors.primaryColorDark,
          ),
          body: model.isBusy
              ? const MainProgress()
              : RefreshIndicator(
                  color: AppColors.goldColor,
                  onRefresh: model.refreshCarServices,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: model.scrollController,
                    child: Column(
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: (model.reservationRepo.reservationsPaginated?.results ?? []).length,
                          separatorBuilder: (context, index) => const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            var item = model.reservationRepo.reservationsPaginated?.results?[index];
                            return ReservationItemWidget(reservationItem: item);
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
        );
      },
    );
  }
}

class MyReservationsScreenModel extends BaseNotifier {
  MyReservationsScreenModel({required this.reservationRepo});
  final ReservationRepo reservationRepo;

  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;

  Future<void> initScrollController() async {
    scrollController.addListener(() async {
      if (scrollController.position.extentAfter == 0) {
        if (!isLoadingMore && reservationRepo.reservationsPaginated?.next != null) {
          await getCarServices();
        }
      }
    });
  }

  Future<void> refreshCarServices() async {
    reservationRepo.reservationsPaginated = null;
    await getCarServices();
  }

  Future<void> getCarServices() async {
    if (reservationRepo.reservationsPaginated == null) {
      setBusy();
    } else {
      isLoadingMore = true;
      setState();
    }
    var res = await reservationRepo.getReservation();
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
