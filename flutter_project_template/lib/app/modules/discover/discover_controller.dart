import 'package:flutter_project_template/app/common/utils/loading.dart';
import 'package:flutter_project_template/app/data/local/store/user_store.dart';
import 'package:flutter_project_template/app/routes/app_pages.dart';
import 'package:get/get.dart';

class DiscoverController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  logout() async {
    Loading.show();
    await UserStore.to.onLogout();
    Get.offAndToNamed(AppRoutes.login);
    Loading.dismiss();
  }
}
