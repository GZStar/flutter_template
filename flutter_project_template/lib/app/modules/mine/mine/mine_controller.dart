import 'package:flutter_project_template/app/data/local/store/user_store.dart';
import 'package:get/get.dart';

import '../../../data/model/user_model.dart';

class MineController extends GetxController {
  UserLoginResponseModel userProfile = UserStore.to.profile;
  var testString = '18888888888'.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}
}
