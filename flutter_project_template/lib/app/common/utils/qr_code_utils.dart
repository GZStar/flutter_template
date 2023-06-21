import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_project_template/app/routes/app_pages.dart';
import 'package:get/instance_manager.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:get/get.dart';

import 'device_utils.dart';

class QrCodeUtils {
  /// 跳转二维码扫码页扫码
  static Future jumpScan({
    isShowScanLine = false, // 是否显示扫描线动画
    isShowGridLine = false, // 是否显示网格线动画，优先级高于扫描线
    Function(String data)? callBack,
  }) async {
    if (DeviceUtils.isMobile) {
      FocusManager.instance.primaryFocus?.unfocus();

      // 延时保证键盘收起，否则进入扫码页会黑屏
      Future<dynamic>.delayed(const Duration(milliseconds: 500), () async {
        // Get.toNamed(AppRoutes.qrcode)?.then((value) {
        //   callBack?.call(value.toString());
        // });

        var result = await Get.toNamed(AppRoutes.qrcode);
        callBack?.call(result.toString());
      });
    } else {
      EasyLoading.showError('当前平台暂不支持');
    }
  }

  /// 生成二维码（中间带图片）
  static Widget createQRCode(String data, double size,
      {Color? backgroundColor,
      Color? foregroundColor,
      EdgeInsets? padding,
      ImageProvider? image,
      Size? imageSize}) {
    return QrImage(
      data: data,
      size: size,
      backgroundColor:
          backgroundColor == null ? Color(0x00FFFFFF) : backgroundColor,
      foregroundColor:
          foregroundColor == null ? Color(0xFF000000) : foregroundColor,
      padding: padding == null ? EdgeInsets.all(10.0) : padding,
      embeddedImage: image,
      embeddedImageStyle: QrEmbeddedImageStyle(size: imageSize),
    );
  }

  ///  barcode_scan 扫码
  static Future scan({
    Function(String data)? callBack,
  }) async {
    Future.delayed(Duration(milliseconds: 500), () {
      try {
        const ScanOptions options = ScanOptions(
          strings: {
            'cancel': '取消',
            'flash_on': '开启闪光灯',
            'flash_off': '关闭闪光灯',
          },
        );
        BarcodeScanner.scan(options: options).then((ScanResult result) {
          if (result.rawContent.length > 0) {
            callBack?.call(result.rawContent);
          }
        });
      } catch (e) {
        if (e is PlatformException) {
          if (e.code == BarcodeScanner.cameraAccessDenied) {
            EasyLoading.showError('没有相机权限！');
          }
        }
      }
    });
  }

  ///  barcode_scan 扫码
// static Future<String> scan() async {
//   try {
//     const ScanOptions options = ScanOptions(
//       strings: {
//         'cancel': '取消',
//         'flash_on': '开启闪光灯',
//         'flash_off': '关闭闪光灯',
//       },
//     );
//     final ScanResult result = await BarcodeScanner.scan(options: options);
//     print('========== 23432423423434234234 ==========');
//     print('object: ${result.toString()}');
//     print('object: ${result.rawContent}');
//
//     return result.rawContent;
//   } catch (e) {
//     if (e is PlatformException) {
//       if (e.code == BarcodeScanner.cameraAccessDenied) {
//         JhProgressHUD.showText('没有相机权限！');
//       }
//     }
//   }
//   return '';
// }
/*
   Future.delayed(Duration(milliseconds: 400), () {
        JhQrCodeUtils.scan().then((data) {
          print('扫码结果：$data');
         });
    });
*/

}
