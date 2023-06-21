import 'package:get/get.dart';

import '../../mine/mine/mine_index.dart';
import '../../contacts/contact_index.dart';
import '../../discover/discover_index.dart';
import '../../home/home_index.dart';
import 'main_tabbar_index.dart';

class MainTabbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainTabbarController>(() => MainTabbarController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ContactController>(() => ContactController());
    Get.lazyPut<DiscoverController>(() => DiscoverController());
    Get.lazyPut<MineController>(() => MineController());
  }
}
