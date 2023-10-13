import 'package:flutter_project_template/app/routes/main_routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onReady() async {
    super.onReady();

    // 三秒后跳转
    await Future.delayed(const Duration(milliseconds: 3000));
    Get.offNamed(MainRoutes.guide);
  }

  @override
  void onClose() {}
}
