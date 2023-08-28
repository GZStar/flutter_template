import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_project_template/app/common/utils/cache_utils.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  var cacheSizeString = ''.obs;

  @override
  void onInit() {
    super.onInit();

    getSize();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void getSize() async {
    var cache = await CacheUtils.loadApplicationCache();

    cacheSizeString.value = CacheUtils.renderSize(cache);
  }

  void cleanCache() async {
    try {
      EasyLoading.show(status: '清除中');
      CacheUtils.clearApplicationCache();
      EasyLoading.dismiss();
      EasyLoading.showSuccess('清除成功');
      cacheSizeString.value = '0.00B';
    } catch (err) {
      print(err);
      EasyLoading.dismiss();
      EasyLoading.showError('清除失败');
    }
  }
}
