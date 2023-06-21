import 'package:flutter/material.dart';

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

  void login() async {
    if (loginFormKey.currentState!.validate()) {
      var params = {
        "phoneNum": loginAccountController.value.text,
        "pwd": EncryptUtils.aesEncrypt(loginPasswordController.value.text),
        "countryCode": "+86"
      };

      Loading.show();
      HttpUtils.request(
        LoginAPI.loginWithPassword(params),
        success: (data) {
          UserLoginResponseModel userProfile =
              UserLoginResponseModel.fromJson(data);
          UserStore.to.saveProfile(userProfile);
          Loading.dismiss();

          Get.offAndToNamed(AppRoutes.mainTabbar);
        },
        fail: (code, msg) {
          Loading.dismiss();
          Get.offAndToNamed(AppRoutes.mainTabbar);
        },
      );
    }
  }
}
