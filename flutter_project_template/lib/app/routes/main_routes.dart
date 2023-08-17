import 'package:get/get.dart';

import '../common/widgets/qr_code_scanner_page.dart';
import '../modules/main/guide/guide_binding.dart';
import '../modules/main/guide/guide_view.dart';
import '../modules/main/main_tabbar/main_tabbar_binding.dart';
import '../modules/main/main_tabbar/main_tabbar_view.dart';
import '../modules/main/splash/splash_binding.dart';
import '../modules/main/splash/splash_view.dart';
import 'middlewares/router_guide.dart';

abstract class MainRoutes {
  /// 设置
  static const splash = '/';
  static const guide = '/guide';
  static const mainTabbar = '/mainTabbar';
  // notfound
  static const notFound = '/notfound';

  static const qrcode = '/qrcode';
}

class MainPages {
  static final routes = <GetPage>[
    GetPage(
      name: MainRoutes.splash,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: MainRoutes.guide,
      page: () => GuideView(),
      binding: GuideBinding(),
      middlewares: [RouteGuideMiddleware(priority: 1)],
    ),
    GetPage(
        name: MainRoutes.mainTabbar,
        page: () => MainTabbarView(),
        binding: MainTabbarBinding()),
    GetPage(name: MainRoutes.qrcode, page: () => QrCodeScannerPage()),
  ];
}
