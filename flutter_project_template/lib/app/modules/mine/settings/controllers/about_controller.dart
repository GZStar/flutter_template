import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../common/utils/device_utils.dart';

class AboutController extends GetxController {
  var currentAppName = ''.obs;
  var currentVersion = ''.obs;

  @override
  void onInit() {
    super.onInit();

    getDeviceInfo();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void getDeviceInfo() async {
    if (GetPlatform.isIOS) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print(iosInfo.toString());
      print('name ${iosInfo.name}');
      print('Running on ${iosInfo.utsname.machine}');
      print('Running on ${iosInfo.utsname.sysname}');
      print('Running on ${iosInfo.utsname.nodename}');
      print('Running on ${iosInfo.utsname.release}');
      print('Running on ${iosInfo.utsname.version}');
    }

    print('---------------------------------------');

    PackageInfo packageInfo = await DeviceUtils.getPackageInfo();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    print('appName $appName');
    print('packageName $packageName');
    print('version $version');
    print('buildNumber $buildNumber');

    currentAppName.value = appName;
    currentVersion.value = '$version build($buildNumber)';
  }
}
