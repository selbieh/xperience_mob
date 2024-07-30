import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/config/logger.dart';
import 'package:xperience/model/data/repo/booking_repo.dart';
import 'package:xperience/model/data/repo/reservations_repo.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/screens/home/payment/payment_screen.dart';
import 'package:xperience/view/screens/menu/reservation_details_screen.dart';
import 'package:xperience/view/widgets/components/main_error_widget.dart';
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
        bookingRepo: Provider.of<BookingRepo>(context),
      ),
      initState: (model) {
        model.initScrollController();
        // if ((model.reservationRepo.reservationsPaginated?.results ?? []).isEmpty) {
        //   model.getCarServices();
        // }
        model.reservationRepo.reservationsPaginated = null;
        model.getCarServices();
      },
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primaryColorDark,
            title: const Text("My resevations").localize(context),
            // actions: [
            //   IconButton(
            //     icon: const Icon(Icons.payment),
            //     onPressed: () {
            //       NavService().pushKey(
            //         // const SuccessScreen(isSuccess: false),
            //         const PaymentScreen(
            //           paymentUrl: "https://secure-egypt.paytabs.com/payment/wr/5C7BC50082E4929950748C8CC7F9D009134C8DCCA5BC68952635C7C1",
            //         ),
            //       );
            //     },
            //   ),
            // ],
          ),
          body: model.isBusy
              ? const MainProgress()
              : RefreshIndicator(
                  color: AppColors.goldColor,
                  onRefresh: model.refreshCarServices,
                  child: model.hasError
                      ? MainErrorWidget(
                          error: model.failure,
                          onRetry: model.refreshCarServices,
                        )
                      : (model.reservationRepo.reservationsPaginated?.results ?? []).isEmpty
                          ? Center(child: Text("No items found".tr()))
                          : SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
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
                                      return InkWell(
                                        child: ReservationItemWidget(
                                          reservationItem: item,
                                          // onPressedPay: () => model.getPaymentURL(item?.id ?? -1),
                                          onPressedPay: () {
                                            Logger.printObject(item?.toJson());
                                            NavService().pushKey(ReservationDetailsScreen(reservation: item));
                                          },
                                        ),
                                        onTap: () {
                                          Logger.printObject(item?.toJson());
                                          NavService().pushKey(ReservationDetailsScreen(reservation: item));
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
        );
      },
    );
  }
}

class MyReservationsScreenModel extends BaseNotifier {
  MyReservationsScreenModel({required this.reservationRepo, required this.bookingRepo});
  final ReservationRepo reservationRepo;
  final BookingRepo bookingRepo;

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

  Future<void> getPaymentURL(int? reservationId) async {
    setBusy();
    var res = await bookingRepo.getPaymentURL(
      body: {"reservation_id": reservationId},
    );
    if (res.left != null) {
      failure = res.left?.message;
      DialogsHelper.messageDialog(message: "${res.left?.message}");
      setError();
    } else {
      setIdle();
      final result = await NavService().pushKey(PaymentScreen(
        paymentUrl: "${res.right}",
        isFromReservation: true,
        reservationId: reservationId ?? -1,
      ));
      if (result == true) {
        refreshCarServices();
      }
    }
  }
}
