import 'package:get/get.dart';
import 'contact_controller.dart';

class ContactBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactController>(() => ContactController());
  }
}
