import 'package:flutter_project_template/app/modules/discover/friends_circle/friends_circle_binding.dart';
import 'package:flutter_project_template/app/modules/main/notfound/notfound_binding.dart';
import 'package:flutter_project_template/app/modules/main/notfound/notfound_view.dart';
import 'package:flutter_project_template/app/modules/mine/settings/bindings/about_binding.dart';
import 'package:flutter_project_template/app/modules/mine/settings/bindings/env_setting_binding.dart';
import 'package:flutter_project_template/app/modules/mine/settings/bindings/settings_binding.dart';
import 'package:flutter_project_template/app/modules/mine/settings/views/about_view.dart';
import 'package:flutter_project_template/app/modules/mine/settings/views/env_setting_view.dart';
import 'package:flutter_project_template/app/modules/mine/settings/views/theme_setting_view.dart';
import 'package:flutter_project_template/app/modules/travel/bindings/travel_binding.dart';
import 'package:flutter_project_template/app/modules/travel/views/travel_view.dart';
import 'package:get/get.dart';

import '../common/widgets/qr_code_scanner_page.dart';
import '../modules/discover/friends_circle/friends_circle_view.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';
import '../modules/login/login_binding.dart';
import '../modules/login/login_view.dart';
import '../modules/main/main_tabbar/main_tabbar_index.dart';
import '../modules/mine/settings/bindings/language_setting_binding.dart';
import '../modules/mine/settings/bindings/theme_setting_binding.dart';
import '../modules/mine/settings/views/language_setting_view.dart';
import '../modules/main/guide/guide_index.dart';
import '../modules/main/splash/splash_index.dart';
import '../modules/mine/settings/views/settings_view.dart';
import 'middlewares/router_guide.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = AppRoutes.splash;

  static final GetPage unknown = GetPage(
    name: AppRoutes.notFound,
    page: () => const NotfoundPage(),
    binding: NotfoundBinding(),
  );

  static final routes = <GetPage>[
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.guide,
      page: () => GuideView(),
      binding: GuideBinding(),
      middlewares: [RouteGuideMiddleware(priority: 1)],
    ),
    GetPage(
        name: AppRoutes.mainTabbar,
        page: () => MainTabbarView(),
        binding: MainTabbarBinding()),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
        name: AppRoutes.settings,
        page: () => SettingsView(),
        binding: SettingsBinding()),
    GetPage(
      name: AppRoutes.languageSetting,
      page: () => LanguageSettingView(),
      binding: LanguageSettingBinding(),
    ),
    GetPage(
      name: AppRoutes.themeSetting,
      page: () => ThemeSettingView(),
      binding: ThemeSettingBinding(),
    ),
    GetPage(
      name: AppRoutes.about,
      page: () => AboutView(),
      binding: AboutBinding(),
    ),
    GetPage(
      name: AppRoutes.envSetting,
      page: () => EnvSettingView(),
      binding: EnvSettingBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(name: AppRoutes.qrcode, page: () => QrCodeScannerPage()),
    GetPage(
        name: AppRoutes.friendsCircle,
        page: () => FriendsCircleView(),
        binding: FriendsCirlcelBinding()),
    GetPage(
        name: AppRoutes.travel,
        page: () => TravelView(),
        binding: TravelBinding()),
  ];
}
