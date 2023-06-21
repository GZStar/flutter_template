import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceUtils {
  static bool get isDesktop => !isWeb && (isWindows || isLinux || isMacOS);

  static bool get isMobile => isAndroid || isIOS;

  static bool get isWeb => kIsWeb;

  static bool get isWindows => Platform.isWindows;

  static bool get isLinux => Platform.isLinux;

  static bool get isMacOS => Platform.isMacOS;

  static bool get isAndroid => Platform.isAndroid;

  static bool get isFuchsia => Platform.isFuchsia;

  static bool get isIOS => Platform.isIOS;

  static Future<PackageInfo> getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo;
  }

  static Future<String> appName() async {
    PackageInfo packageInfo = await getPackageInfo();
    return packageInfo.appName;
  }

  static Future<String> packageName() async {
    PackageInfo packageInfo = await getPackageInfo();
    return packageInfo.packageName;
  }

  static Future<String> version() async {
    PackageInfo packageInfo = await getPackageInfo();
    return packageInfo.version;
  }

  static Future<String> buildNumber() async {
    PackageInfo packageInfo = await getPackageInfo();
    return packageInfo.buildNumber;
  }

/* 使用

 void _getPackageInfo() async {
    PackageInfo packageInfo = await DeviceUtils.getPackageInfo();
    print('packageInfo：');
    print(packageInfo.appName);
    print(packageInfo.packageName);
    print(packageInfo.version);
    print(packageInfo.buildNumber);
  }

 void _getPackageInfo() async {
    String version = await DeviceUtils.version();
    print('app version = ：$version');
    setState(() {
      _currentVersion = version;
    });
  }

  void _getPackageInfo() {
    DeviceUtils.version().then((version) {
      print('app version = ：$version');
      setState(() {
        _currentVersion = version;
      });
    });
  }

*/

}
