import 'package:get/get.dart';
import 'notfound_controller.dart';

class NotfoundBinding extends Bindings {
    @override
    void dependencies() {
    Get.lazyPut<NotfoundController>(() => NotfoundController());
    }
}
