import 'package:get/get.dart';

import '../controllers/env_type_controller.dart';

class EnvTypeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EnvTypeController>(
      () => EnvTypeController(),
    );
  }
}
