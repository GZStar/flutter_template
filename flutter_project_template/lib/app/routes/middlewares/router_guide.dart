import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/local/store/config_store.dart';
import '../../data/local/store/user_store.dart';
import '../app_pages.dart';

/// 第一次欢迎页面
class RouteGuideMiddleware extends GetMiddleware {
  // priority 数字小优先级高
  @override
  int? priority = 0;

  RouteGuideMiddleware({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    if (ConfigStore.to.isFirstOpen == false) {
      return null;
    } else if (UserStore.to.isLogin == true) {
      return const RouteSettings(name: AppRoutes.mainTabbar);
    } else {
      return const RouteSettings(name: AppRoutes.login);
    }
  }
}
