import 'package:flutter/material.dart';
import 'package:flutter_project_template/app/routes/login_routes.dart';
import 'package:flutter_project_template/app/routes/main_routes.dart';
import 'package:flutter_project_template/app/routes/mine_routes.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/set_cell.dart';
import '../../../../data/local/store/user_store.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('setting view build');
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr),
        centerTitle: true,
      ),
      body: getContentBody(),
    );
  }

  // cell
  Widget getContentBody() {
    return Obx(
      () => ListView(
        children: <Widget>[
          CommonSetCell(
              title: 'set_language'.tr,
              clickCallBack: () {
                Get.toNamed(MineRoutes.languageSetting);
              }),
          CommonSetCell(
              title: 'appearance'.tr,
              hiddenLine: true,
              clickCallBack: () {
                Get.toNamed(MineRoutes.themeSetting);
              }),
          const SizedBox(height: 8),
          CommonSetCell(
              title: 'clear_cache'.tr,
              text: controller.cacheSizeString.value,
              clickCallBack: () {
                controller.cleanCache();
              }),
          CommonSetCell(
              title: '用户条款'.tr,
              clickCallBack: () {
                Get.toNamed(MainRoutes.webBrowser, arguments: {
                  'title': '用户条款',
                  'url': 'https://democustapp.jtjms-mx.com/en-us/termofuse'
                });
              }),
          CommonSetCell(
              title: '隐私协议'.tr,
              clickCallBack: () {
                Get.toNamed(MainRoutes.webBrowser, arguments: {
                  'title': '隐私协议',
                  'url': 'https://democustapp.jtjms-mx.com/en-us/privacyPolicy'
                });
              }),
          CommonSetCell(title: '帮助与反馈'.tr, clickCallBack: () {}),
          CommonSetCell(
            title: 'about'.tr,
            text: 'v1.0.0',
            hiddenLine: true,
            clickCallBack: () {
              Get.toNamed(MineRoutes.about);
            },
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 50,
            child: TextButton(
              onPressed: () {
                UserStore.to.onLogout();
                Get.offAllNamed(AccountRoutes.login);
              },
              child: Text('logout'.tr,
                  style: const TextStyle(color: Colors.red, fontSize: 20)),
            ),
          ),
        ],
      ),
    );
  }
}
