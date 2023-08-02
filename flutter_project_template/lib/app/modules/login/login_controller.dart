import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_project_template/app/common/widgets/toast.dart';
import 'package:flutter_project_template/app/data/network/error_handle.dart';

import 'package:get/get.dart';
import '../../common/utils/encrypt_utils.dart';
import '../../common/utils/loading.dart';
import '../../data/apis/login.dart';
import '../../data/local/store/user_store.dart';
import '../../data/model/user_model.dart';
import '../../data/network/http_utils.dart';
import '../../routes/app_pages.dart';

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

  void login() {
    if (loginFormKey.currentState!.validate()) {
      var params = {
        "phoneNum": loginAccountController.value.text,
        "pwd": EncryptUtils.aesEncrypt(loginPasswordController.value.text),
        "countryCode": "+86"
      };

      fetchLogin(params);
    }
  }

  void fetchLogin(params) async {
    Loading.show();
    try {
      UserLoginResponseModel userProfile =
          await LoginAPI.loginWithPassword(params);
      UserStore.to.saveProfile(userProfile);
      Loading.dismiss();
      Get.offAndToNamed(AppRoutes.mainTabbar);
    } on NetError catch (e) {
      Loading.dismiss();
      showWarnToast(e.msg);
      Get.offAndToNamed(AppRoutes.mainTabbar);
    }
  }
}
