import 'dart:convert';

import 'package:get/get.dart';

import '../../../common/values/storage_key.dart';
import '../../model/user_model.dart';
import 'storage_service.dart';

class UserStore extends GetxController {
  static UserStore get to => Get.find();

  // 是否登录
  final _isLogin = false.obs;
  // 令牌 token
  String token = '';
  // 用户 profile
  final _profile = UserLoginResponseModel().obs;

  bool get isLogin => _isLogin.value;
  UserLoginResponseModel get profile => _profile.value;
  bool get hasToken => token.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    token = StorageService.to.getString(StorageKeys.userToken);
    var profileOffline = StorageService.to.getString(StorageKeys.userProfile);
    if (profileOffline.isNotEmpty) {
      _profile(UserLoginResponseModel.fromJson(jsonDecode(profileOffline)));
    }

    getProfile();
  }

  // 获取 profile
  Future<void> getProfile() async {
    if (token.isEmpty) return;
    // var result = await UserAPI.profile();
    // _profile(result);
    _isLogin.value = true;
    // StorageService.to.setString(StorageKeys.userProfile, jsonEncode(result));
  }

  // 保存 token
  Future<void> setToken(String value) async {
    await StorageService.to.setString(StorageKeys.userToken, value);
    token = value;
  }

  // 保存 profile
  Future<void> saveProfile(UserLoginResponseModel profile) async {
    if (profile.token != null) {
      _isLogin.value = true;
      StorageService.to.setString(StorageKeys.userProfile, jsonEncode(profile));

      _profile(profile);
      setToken(profile.token!);
    }
  }

  // 注销
  Future<void> onLogout() async {
    // if (_isLogin.value) await UserAPI.logout();
    await StorageService.to.remove(StorageKeys.userProfile);
    await StorageService.to.remove(StorageKeys.userToken);

    _isLogin.value = false;
    token = '';
  }
}
