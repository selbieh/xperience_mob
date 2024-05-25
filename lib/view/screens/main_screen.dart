// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/config/logger.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/screens/home/home_tab_screen.dart';
import 'package:xperience/view/screens/home/menu_drawer_screen.dart';
import 'package:xperience/view/screens/home/more_tab_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<MainScreenModel>(
      model: MainScreenModel(),
      builder: (_, model, child) {
        // return DefaultTabController(
        //   length: model.listTabs.length,
        //   child: Scaffold(
        return Scaffold(
          key: model.scaffoldKey,
          drawer: const MenuDrawerScreen(),
          onDrawerChanged: model.onDrawerChanged,
          body: model.listTabs[model.pageIndex],
          bottomNavigationBar: SizedBox(
            // height: Platform.isIOS ? 70 : 70,
            height: 70,
            child: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/svgs/ic_tab_home.svg",
                    color: model.pageIndex == 0 ? AppColors.white : AppColors.greyText,
                  ),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/svgs/ic_tab_menu.svg",
                    color: model.pageIndex == 1 ? AppColors.white : AppColors.greyText,
                  ),
                  label: "More",
                ),
              ],
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppColors.primaryColorLight,
              elevation: 0,
              currentIndex: model.pageIndex,
              selectedItemColor: AppColors.white,
              unselectedItemColor: AppColors.greyText,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
              unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
              showSelectedLabels: true,
              showUnselectedLabels: true,
              onTap: model.changePageIndex,
            ),
          ),
          // ========================================================================================================
          // bottomNavigationBar: Material(
          //   color: AppColors.primaryColorLight,
          //   child: TabBar(
          //     unselectedLabelColor: AppColors.greyText,
          //     indicatorSize: TabBarIndicatorSize.tab,
          //     labelStyle: const TextStyle(fontWeight: FontWeight.normal, color: AppColors.white),
          //     unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, color: AppColors.greyText),
          //     indicator: TopIndicator(),
          //     tabs: [
          //       Tab(
          //         icon: SvgPicture.asset(
          //           "assets/svgs/ic_tab_home.svg",
          //           color: model.pageIndex == 0 ? AppColors.white : AppColors.greyText,
          //         ),
          //         text: 'Home',
          //       ),
          //       Tab(
          //         icon: SvgPicture.asset(
          //           "assets/svgs/ic_tab_menu.svg",
          //           color: model.pageIndex == 1 ? AppColors.white : AppColors.greyText,
          //         ),
          //         text: 'More',
          //       ),
          //     ],
          //     onTap: model.changePageIndex,
          //   ),
          // ),
          // ========================================================================================================
        );
      },
    );
  }
}

class MainScreenModel extends BaseNotifier {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int pageIndex = 0;
  final List<Widget> listTabs = [
    const HomeTabScreen(),
    const MoreTabScreen(),
  ];

  changePageIndex(int index) {
    if (index < 1) {
      Logger.printt(index);
      pageIndex = index;
      setState();
    } else {
      scaffoldKey.currentState?.openDrawer();
    }
  }

  void onDrawerChanged(bool isOpened) {
    if (isOpened) {
      setState();
    } else {
      setState();
    }
    Logger.log("pageIndex: $pageIndex");
  }
}

class TopIndicator extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _TopIndicatorBox();
  }
}

class _TopIndicatorBox extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    Paint paint = Paint()
      ..color = AppColors.goldColor2
      ..strokeWidth = 2.0
      ..isAntiAlias = true;

    canvas.drawLine(offset, Offset(cfg.size!.width + offset.dx, 0), paint);
  }
}
