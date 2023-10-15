import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_project_template/app/modules/travel/views/travel_view.dart';

import 'package:get/get.dart';

import '../../../common/style/my_icons.dart';
import '../../discover/index/discover_view.dart';
import 'main_tabbar_controller.dart';
import '../../home/home_index.dart';
import '../../mine/mine/mine_index.dart';

class MainTabbarView extends GetView<MainTabbarController> {
  const MainTabbarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        onPageChanged: (index) => controller.onJumpTo(index),
        physics: const NeverScrollableScrollPhysics(),
        children: const <Widget>[
          HomeView(),
          TravelView(),
          DiscoverView(),
          MineView()
        ],
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  // 底部导航
  Widget buildBottomNavigationBar() {
    return Obx(() => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: getBottomNavBarItems(),
          unselectedFontSize: 12,
          selectedFontSize: 12,
          // backgroundColor: Colors.green,
          // selectedItemColor: AppColors.primaryColor,
          currentIndex: controller.currentIndex.value,
          onTap: (index) => controller.onJumpTo(index),
        ));
  }

  List<BottomNavigationBarItem> getBottomNavBarItems() {
    // 底部图标按钮区域
    return (<BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: const Icon(MyIcons.home),
        activeIcon: const Icon(MyIcons.home),
        label: 'home'.tr,
      ),
      BottomNavigationBarItem(
        icon: const Icon(MyIcons.work),
        activeIcon: const Icon(MyIcons.work),
        label: "travel".tr,
      ),
      BottomNavigationBarItem(
        icon: badges.Badge(
          badgeColor: Colors.red,
          showBadge: true,
          padding: const EdgeInsets.all(4),
          position: const badges.BadgePosition(top: -1, end: -5),
          child: const Icon(MyIcons.calendar),
        ),
        activeIcon: badges.Badge(
          badgeColor: Colors.red,
          showBadge: true,
          padding: const EdgeInsets.all(4),
          position: const badges.BadgePosition(top: -1, end: -5),
          child: const Icon(MyIcons.calendar),
        ),
        label: 'discover'.tr,
      ),
      BottomNavigationBarItem(
        icon: const Icon(MyIcons.mine),
        activeIcon: const Icon(MyIcons.mine),
        label: 'mine'.tr,
      ),
    ]);
  }
}
