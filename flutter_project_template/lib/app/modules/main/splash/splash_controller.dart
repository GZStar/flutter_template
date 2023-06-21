import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onReady() async {
    super.onReady();

    // 三秒后跳转
    await Future.delayed(const Duration(milliseconds: 3000));
    Get.offNamed(AppRoutes.guide);
  }

  @override
  void onClose() {}
}
