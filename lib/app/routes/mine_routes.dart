import 'package:flutter_project_template/app/modules/mine/settings/env/envType/bindings/env_type_binding.dart';
import 'package:flutter_project_template/app/modules/mine/settings/env/envType/views/env_type_view.dart';
import 'package:flutter_project_template/app/modules/mine/settings/env/settingEnv/bindings/setting_env_binding.dart';
import 'package:flutter_project_template/app/modules/mine/settings/env/settingEnv/views/setting_env_view.dart';
import 'package:flutter_project_template/app/modules/mine/settings/env/settingProxy/bindings/setting_proxy_binding.dart';
import 'package:flutter_project_template/app/modules/mine/settings/env/settingProxy/views/setting_proxy_view.dart';
import 'package:flutter_project_template/app/modules/mine/testImage/bindings/test_image_binding.dart';
import 'package:flutter_project_template/app/modules/mine/testImage/views/test_image_view.dart';
import 'package:flutter_project_template/app/modules/mine/userProfile/bindings/user_profile_binding.dart';
import 'package:flutter_project_template/app/modules/mine/userProfile/views/user_profile_view.dart';
import 'package:flutter_project_template/app/modules/mine/userQrCode/views/user_qr_code_view.dart';
import 'package:get/get.dart';

import '../modules/mine/settings/bindings/about_binding.dart';
import '../modules/mine/settings/bindings/language_setting_binding.dart';
import '../modules/mine/settings/bindings/settings_binding.dart';
import '../modules/mine/settings/bindings/theme_setting_binding.dart';
import '../modules/mine/settings/views/about_view.dart';
import '../modules/mine/settings/views/language_setting_view.dart';
import '../modules/mine/settings/views/settings_view.dart';
import '../modules/mine/settings/views/theme_setting_view.dart';

abstract class MineRoutes {
  /// 设置
  static const settings = '/settings';
  static const languageSetting = '/settings/languageSetting';
  static const themeSetting = '/settings/themeSetting';
  static const about = '/settings/about';

  static const envType = '/settings/envType';
  static const envSetting = '/settings/envSetting';
  static const proxySetting = '/settings/proxySetting';

  // 个人信息
  static const userProfile = '/userProfile';
  static const userQrCode = '/userProfile/qrCode';

  static const testImage = '/testImage';
}

class MinePages {
  static final routes = <GetPage>[
    GetPage(
        name: MineRoutes.settings,
        page: () => const SettingsView(),
        binding: SettingsBinding()),
    GetPage(
      name: MineRoutes.languageSetting,
      page: () => const LanguageSettingView(),
      binding: LanguageSettingBinding(),
    ),
    GetPage(
      name: MineRoutes.themeSetting,
      page: () => const ThemeSettingView(),
      binding: ThemeSettingBinding(),
    ),
    GetPage(
      name: MineRoutes.about,
      page: () => const AboutView(),
      binding: AboutBinding(),
    ),
    GetPage(
      name: MineRoutes.userProfile,
      page: () => const UserProfileView(),
      binding: UserProfileBinding(),
    ),
    GetPage(
      name: MineRoutes.userQrCode,
      page: () => const UserQrCodeView(),
      binding: UserProfileBinding(),
    ),
    GetPage(
      name: MineRoutes.testImage,
      page: () => const TestImageView(),
      binding: TestImageBinding(),
    ),
    GetPage(
      name: MineRoutes.envType,
      page: () => const EnvTypeView(),
      binding: EnvTypeBinding(),
    ),
    GetPage(
      name: MineRoutes.envSetting,
      page: () => const SettingEnvView(),
      binding: SettingEnvBinding(),
    ),
    GetPage(
      name: MineRoutes.proxySetting,
      page: () => const SettingProxyView(),
      binding: SettingProxyBinding(),
    ),
  ];
}
