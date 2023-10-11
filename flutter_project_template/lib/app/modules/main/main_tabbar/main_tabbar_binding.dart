import 'package:get/get.dart';

import '../../discover/index/discover_controller.dart';
import '../../mine/mine/mine_index.dart';
import '../../home/home_index.dart';
import '../../travel/controllers/travel_controller.dart';
import 'main_tabbar_index.dart';

class MainTabbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainTabbarController>(() => MainTabbarController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<TravelController>(() => TravelController());
    Get.lazyPut<DiscoverController>(() => DiscoverController());
    Get.lazyPut<MineController>(() => MineController());
  }
}
