import 'package:get/get.dart';
import 'guide_controller.dart';

class GuideBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GuideController>(() => GuideController());
  }
}
