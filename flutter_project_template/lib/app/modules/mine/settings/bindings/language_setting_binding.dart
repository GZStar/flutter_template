import 'package:get/get.dart';
import '../controllers/language_setting_controller.dart';

class LanguageSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LanguageSettingController>(() => LanguageSettingController());
  }
}
