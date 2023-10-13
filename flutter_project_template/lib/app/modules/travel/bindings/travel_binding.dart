import 'package:get/get.dart';

import '../controllers/travel_controller.dart';

class TravelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TravelController>(
      () => TravelController(),
    );
  }
}
