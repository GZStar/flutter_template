import 'package:get/get.dart';

import '../modules/mine/settings/bindings/about_binding.dart';
import '../modules/mine/settings/bindings/env_setting_binding.dart';
import '../modules/mine/settings/bindings/language_setting_binding.dart';
import '../modules/mine/settings/bindings/settings_binding.dart';
import '../modules/mine/settings/bindings/theme_setting_binding.dart';
import '../modules/mine/settings/views/about_view.dart';
import '../modules/mine/settings/views/env_setting_view.dart';
import '../modules/mine/settings/views/language_setting_view.dart';
import '../modules/mine/settings/views/settings_view.dart';
import '../modules/mine/settings/views/theme_setting_view.dart';

abstract class MineRoutes {
  /// 设置
  static const settings = '/settings';
  static const languageSetting = '/languageSetting';
  static const themeSetting = '/themeSetting';
  static const envSetting = '/envSetting';
  static const about = '/about';
}

class MinePages {
  static final routes = <GetPage>[
    GetPage(
        name: MineRoutes.settings,
        page: () => SettingsView(),
        binding: SettingsBinding()),
    GetPage(
      name: MineRoutes.languageSetting,
      page: () => LanguageSettingView(),
      binding: LanguageSettingBinding(),
    ),
    GetPage(
      name: MineRoutes.themeSetting,
      page: () => ThemeSettingView(),
      binding: ThemeSettingBinding(),
    ),
    GetPage(
      name: MineRoutes.about,
      page: () => AboutView(),
      binding: AboutBinding(),
    ),
    GetPage(
      name: MineRoutes.envSetting,
      page: () => EnvSettingView(),
      binding: EnvSettingBinding(),
    ),
  ];
}
