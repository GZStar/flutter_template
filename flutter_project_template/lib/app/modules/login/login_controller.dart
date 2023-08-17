import 'package:flutter/material.dart';
import 'package:flutter_project_template/app/common/widgets/toast.dart';
import 'package:flutter_project_template/app/data/network/error_handle.dart';
import 'package:flutter_project_template/app/routes/main_routes.dart';

import 'package:get/get.dart';
import '../../common/utils/loading.dart';
import '../../data/apis/login.dart';
import '../../data/local/store/user_store.dart';
import '../../data/model/user_model.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final loginAccountController = TextEditingController();
  final loginPasswordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void login() async {
    if (loginFormKey.currentState!.validate()) {
      Loading.show();
      try {
        UserLoginResponseModel userProfile = await LoginAPI.loginWithPassword(
            loginAccountController.value.text,
            loginPasswordController.value.text);
        UserStore.to.saveProfile(userProfile);
        Loading.dismiss();
        Get.offAndToNamed(MainRoutes.mainTabbar);
      } on NetError catch (e) {
        Loading.dismiss();
        showWarnToast(e.msg);

        UserStore.to.isLogin = true;
        Get.offAndToNamed(MainRoutes.mainTabbar);
      }
    }
  }
}
