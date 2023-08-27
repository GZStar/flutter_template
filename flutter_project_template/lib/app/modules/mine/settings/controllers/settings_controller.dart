import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_project_template/app/common/utils/cache_utils.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

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
    // final tempDir = await getTemporaryDirectory();
    // var cache = await CacheUtils.getTotalSizeOfFilesInDir(tempDir);

    // cacheSizeString.value = CacheUtils.renderSize(cache);
  }

  void cleanCache() async {
    // try {
    //   final tempDir = await getTemporaryDirectory();
    //   EasyLoading.show(status: '清除中');
    //   await CacheUtils.requestPermission(tempDir);
    //   EasyLoading.dismiss();
    //   EasyLoading.showSuccess('清除成功');
    //   getSize();
    // } catch (err) {
    //   print(err);
    //   EasyLoading.dismiss();
    //   EasyLoading.showError('清除失败');
    // }
  }
}
