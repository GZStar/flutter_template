import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsUtils {
  static Future<bool> getCameraPermission() async {
    var status = await Permission.camera.request();
    if (status.isPermanentlyDenied) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      Get.defaultDialog(
        middleText: '您还未开启相机相关权限，建议允许访问相机',
        textCancel: '取消',
        textConfirm: '前往设置',
        onConfirm: () {
          openAppSettings();
        },
      );

      return false;
    } else {
      return true;
    }
  }

  static Future<bool> getPhotosPermission() async {
    var status = await Permission.photos.request();
    if (status.isPermanentlyDenied) {
      Get.defaultDialog(
        middleText: '您还未开启相册相关权限，建议允许访问[所有照片]',
        textCancel: '取消',
        textConfirm: '前往设置',
        onConfirm: () {
          openAppSettings();
        },
      );

      return false;
    } else {
      return true;
    }
  }
}
