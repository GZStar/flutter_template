import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'app/data/local/store/config_store.dart';
import 'app/data/local/store/storage_service.dart';
import 'app/data/local/store/user_store.dart';

const kDebugMode = true;

/// 全局静态数据
class Global {
  /// 初始化
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    await Get.putAsync<StorageService>(() => StorageService().init());

    Get.put<ConfigStore>(ConfigStore());
    Get.put<UserStore>(UserStore());

    // 极光推送初始化
    // await PushManager.setup();
  }
}
