import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/services/auth/auth_service.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/router/route_names.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/screens/home/Ultimate/ultimate_start_screen.dart';
import 'package:xperience/view/screens/home/car/cars_services_list_screen.dart';
import 'package:xperience/view/screens/home/hotel/hotel_services_list_screen.dart';
import 'package:xperience/view/screens/menu/notifications_screen.dart';
import 'package:xperience/view/widgets/home_banner_widget.dart';
import 'package:xperience/view/widgets/home_service_item_widget.dart';

class HomeTabScreen extends StatelessWidget {
  const HomeTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeTabViewModel>(
      model: HomeTabViewModel(auth: Provider.of<AuthService>(context)),
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              // "Hello, Sir 👋",
              "${"Hello,".localize(context)} ${model.auth.userModel?.user?.name ?? ""} 👋",
              style: const TextStyle(color: AppColors.greyText),
            ),
            actions: [
              if (model.auth.isLogged)
                IconButton(
                  icon: SvgPicture.asset("assets/svgs/ic_bell.svg"),
                  onPressed: () {
                    NavService().pushKey(const NotificationsScreen());
                    // NavService().pushKey(const CarDetailsScreen());
                  },
                ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: AppColors.primaryColorLight,
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 25, top: 0, right: 25, bottom: 25),
                  child: RichText(
                    text: TextSpan(
                      text: "Good morning".localize(context),
                      style: const TextStyle(
                        fontSize: 22,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      children: <TextSpan>[
                        const TextSpan(text: " "),
                        TextSpan(
                          text: "How can we assist you today?".localize(context),
                          style: const TextStyle(
                            fontSize: 22,
                            color: AppColors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      HomeBannerWidget(imageList: model.imageList),
                      const SizedBox(height: 20),
                      const Text(
                        "Services",
                        style: TextStyle(
                          color: AppColors.greyText,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ).localize(context),
                      const SizedBox(height: 20),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        // physics: const PageScrollPhysics(),
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: [
                            HomeServiceItemWidget(
                              title: "Car Experience".localize(context),
                              subtitle: "Book A Ride!".localize(context),
                              // imageUrl: "https://japan-land-service.com/wp-content/uploads/2019/02/AdobeStock_180552191-2-478x360.jpg",
                              // imageUrl: "assets/images/car_exp.jpeg",
                              imageUrl: "assets/images/service_1.png",
                              onTap: () {
                                NavService().pushKey(
                                  const CarsServicesListScreen(),
                                  settings: const RouteSettings(name: RouteNames.carExperience),
                                );
                              },
                            ),
                            const SizedBox(width: 20),
                            HomeServiceItemWidget(
                              title: "Hotel Experience".localize(context),
                              subtitle: "Book An Hotel Apartment".localize(context),
                              // imageUrl: "https://assets.bwbx.io/images/users/iqjWHBFdfxIU/iyix1OYhVxdA/v2/-1x-1.jpg",
                              // imageUrl: "assets/images/hotel_exp.jpeg",
                              imageUrl: "assets/images/service_2.png",
                              onTap: () {
                                NavService().pushKey(
                                  const HotelServicesListScreen(),
                                  settings: const RouteSettings(name: RouteNames.hotelExperience),
                                );
                              },
                            ),
                            const SizedBox(width: 20),
                            HomeServiceItemWidget(
                              title: "Ultimate Experience".localize(context),
                              subtitle: "Book Fully Service!".localize(context),
                              // imageUrl: "https://assets.bwbx.io/images/users/iqjWHBFdfxIU/iyix1OYhVxdA/v2/-1x-1.jpg",
                              // imageUrl: "assets/images/hotel_exp.jpeg",
                              imageUrl: "assets/images/service_3.png",
                              onTap: () {
                                NavService().pushKey(
                                  const UltimateStartScreen(),
                                  settings: const RouteSettings(name: RouteNames.ultimateExperience),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class HomeTabViewModel extends BaseNotifier {
  HomeTabViewModel({required this.auth});

  final AuthService auth;

  List<String> imageList = [
    "https://hare-media-cdn.tripadvisor.com/media/attractions-splice-spp-720x480/11/fe/57/80.jpg",
    "https://japan-land-service.com/wp-content/uploads/2019/02/AdobeStock_180552191-2-478x360.jpg",
    // "https://media.tacdn.com/media/attractions-splice-spp-674x446/06/6a/b3/fa.jpg",
    "https://aurorahotels.vn/UploadFile/Article/Transfer1.jpg",
  ];
}
