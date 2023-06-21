import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_project_template/app/common/style/app_colors.dart';

import 'package:get/get.dart';

import '../../../common/style/my_icons.dart';
import 'main_tabbar_controller.dart';
import '../../contacts/contact_index.dart';
import '../../discover/discover_index.dart';
import '../../home/home_index.dart';
import '../../mine/mine/mine_index.dart';

class MainTabbarView extends GetView<MainTabbarController> {
  List<Widget> indexedStackPages = [
    HomeView(),
    ContactView(),
    DiscoverView(),
    MineView()
  ];

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: buildBody(),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Widget buildBody() {
    return Obx(() => IndexedStack(
          index: controller.currentIndex.value,
          children: indexedStackPages,
        ));
  }

  // 底部导航
  Widget buildBottomNavigationBar() {
    return Obx(() => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: getBottomNavBarItems(),
          unselectedFontSize: 12,
          selectedFontSize: 12,
          // backgroundColor: Colors.green,
          selectedItemColor: AppColors.primaryColor,
          currentIndex: controller.currentIndex.value,
          onTap: (index) => controller.switchTab(index),
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
        label: "work".tr,
      ),
      BottomNavigationBarItem(
        icon: badges.Badge(
          showBadge: controller.showCalendarBadge.value,
          padding: const EdgeInsets.all(4),
          position: const badges.BadgePosition(top: -1, end: -5),
          child: const Icon(MyIcons.calendar),
        ),
        activeIcon: badges.Badge(
          showBadge: controller.showCalendarBadge.value,
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
