import 'package:flutter_project_template/app/modules/main/video/bindings/video_binding.dart';
import 'package:flutter_project_template/app/modules/main/video/views/video_view.dart';
import 'package:get/get.dart';

import '../common/widgets/qr_code_scanner_page.dart';
import '../modules/main/guide/guide_binding.dart';
import '../modules/main/guide/guide_view.dart';
import '../modules/main/main_tabbar/main_tabbar_binding.dart';
import '../modules/main/main_tabbar/main_tabbar_view.dart';
import '../modules/main/splash/splash_binding.dart';
import '../modules/main/splash/splash_view.dart';
import '../modules/main/webBrowser/bindings/web_browser_binding.dart';
import '../modules/main/webBrowser/views/web_browser_view.dart';
import 'middlewares/router_guide.dart';

abstract class MainRoutes {
  /// 设置
  static const splash = '/';
  static const guide = '/guide';
  static const mainTabbar = '/mainTabbar';
  // notfound
  static const notFound = '/notfound';

  static const qrcode = '/qrcode';

  static const webBrowser = '/webBrowser';
  static const video = '/video';
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
    GetPage(
      name: MainRoutes.webBrowser,
      page: () => WebBrowserView(),
      binding: WebBrowserBinding(),
    ),
    GetPage(
        name: MainRoutes.video,
        page: () => const VideoView(),
        binding: VideoBinding(),
        fullscreenDialog: true,
        transition: Transition.zoom),
  ];
}
