import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_project_template/app/common/style/theme.dart';

import 'package:get/get.dart';

import 'app/common/langs/translation_service.dart';
import 'app/data/local/store/config_store.dart';
import 'app/routes/app_routes.dart';
import 'global.dart';

void main() async {
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      translations: TranslationService(),
      locale: ConfigStore.to.locale,
      fallbackLocale: ConfigStore.fallbackLocale,
      builder: EasyLoading.init(),
      unknownRoute: AppPages.unknown,
      theme: getAppTheme(),
      darkTheme: getAppTheme(isDarkMode: true),
      // theme: ThemeData.light(),
      // darkTheme: ThemeData.dark(),
    );
  }
}
