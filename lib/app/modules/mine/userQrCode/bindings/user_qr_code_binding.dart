import 'package:get/get.dart';

import '../controllers/user_qr_code_controller.dart';

class UserQrCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserQrCodeController>(
      () => UserQrCodeController(),
    );
  }
}
