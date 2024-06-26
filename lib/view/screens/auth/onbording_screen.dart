import 'package:flutter/material.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/router/route_names.dart';
import 'package:xperience/model/services/shared_preference.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/screens/main_screen.dart';
import 'package:xperience/view/widgets/components/main_button.dart';
import 'package:xperience/view/widgets/onboarding_page_item.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<OnboardingScreenViewModel>(
      model: OnboardingScreenViewModel(),
      initState: (model) {
        SharedPref.sharedPref?.setBool(SharedPrefKeys.isFirstLaunch, false);
      },
      builder: (context, model, child) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                PageView(
                  physics: const BouncingScrollPhysics(),
                  controller: model.pageController,
                  onPageChanged: model.onPageChanged,
                  children: [
                    OnboardingPageItem(
                      imagePath: "assets/images/onboarding_2.jpg",
                      title: "Welcome to".localize(context),
                      subtitle: "Xperience.VIP".localize(context),
                      description: "Your One-Stop Destination for Seamless Travel Experience".localize(context),
                    ),
                    OnboardingPageItem(
                      imagePath: "assets/images/onboarding_3.jpeg",
                      title: "Find the".localize(context),
                      subtitle: "Perfect Ride".localize(context),
                      description: "Explore our diverse range of cars, from compact city rides to spacious SUVs, ensuring we meet all your travel needs."
                          .localize(context),
                    ),
                    OnboardingPageItem(
                      imagePath: "assets/images/onboarding_4.jpg",
                      title: "Your Home".localize(context),
                      subtitle: "Away From Home".localize(context),
                      description:
                          "Discover a variety of hotels, from cozy boutiques to luxurious resorts, providing exceptional comfort and service for your next trip."
                              .localize(context),
                    ),
                    OnboardingPageItem(
                      imagePath: "assets/images/onboarding_5.jpg",
                      title: "Ultimate".localize(context),
                      subtitle: "Experience".localize(context),
                      description: "Discover the best deals on cars and hotels tailored to your needs.".localize(context),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildPageIndicator(model),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Row(
                        children: [
                          if (model.currentPage != model.pageCount - 1)
                            MainButton(
                              type: ButtonType.text,
                              radius: 10,
                              height: 60,
                              title: "SKIP".localize(context),
                              color: AppColors.white,
                              onPressed: () => model.animateToPage(model.pageCount - 1),
                            ),
                          if (model.currentPage != model.pageCount - 1) const SizedBox(width: 10),
                          Expanded(
                            child: MainButton(
                              radius: 10,
                              height: 60,
                              color: AppColors.goldColor,
                              textStyle: const TextStyle(color: AppColors.black),
                              title: model.currentPage == model.pageCount - 1 ? "START NOW".localize(context) : "Next".localize(context),
                              onPressed: () {
                                if (model.currentPage == model.pageCount - 1) {
                                  NavService().pushAndRemoveUntilKey(
                                    const MainScreen(),
                                    settings: const RouteSettings(name: RouteNames.mainScreen),
                                  );
                                } else {
                                  model.animateToPage(model.currentPage + 1);
                                }
                              },
                            ),
                          ),
                          // const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget indicator(bool isActive) {
    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.all(3),
        height: 2,
        // width: 0.20.w,
        decoration: BoxDecoration(
          color: isActive ? AppColors.white : AppColors.grey,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }

  Widget buildPageIndicator(OnboardingScreenViewModel model) {
    List<Widget> indicatorList = [];
    for (int i = 0; i < model.pageCount; i++) {
      indicatorList.add(i == model.currentPage ? indicator(true) : indicator(false));
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: indicatorList),
    );
  }
}

class OnboardingScreenViewModel extends BaseNotifier {
  OnboardingScreenViewModel();

  final PageController pageController = PageController(initialPage: 0);
  final int pageCount = 4;
  int currentPage = 0;

  void onPageChanged(int value) {
    currentPage = value;
    setState();
  }

  void animateToPage(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
