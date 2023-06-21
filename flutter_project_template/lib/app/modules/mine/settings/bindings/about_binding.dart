import 'package:flutter_project_template/app/modules/mine/settings/controllers/about_controller.dart';
import 'package:get/get.dart';

class AboutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutController>(() => AboutController());
  }
}
