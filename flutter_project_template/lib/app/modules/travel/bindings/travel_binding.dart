import 'package:get/get.dart';

import 'package:flutter_project_template/app/modules/travel/controllers/travel_page_controller.dart';

import '../controllers/travel_controller.dart';

class TravelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TravelPageController>(
      () => TravelPageController(),
    );
    Get.lazyPut<TravelController>(
      () => TravelController(),
    );
  }
}
