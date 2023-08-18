import 'package:flutter/material.dart';
import 'package:flutter_project_template/app/routes/login_routes.dart';
import 'package:flutter_project_template/app/routes/mine_routes.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/set_cell.dart';
import '../../../../data/local/store/user_store.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    return ListView(
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
        CommonSetCell(title: 'clear_cache'.tr, clickCallBack: () {}),
        CommonSetCell(title: '网络检测'.tr, clickCallBack: () {}),
        CommonSetCell(
          title: 'about'.tr,
          text: 'v2.0.1',
          hiddenLine: true,
          clickCallBack: () {
            Get.toNamed(MineRoutes.about);
          },
        ),
        const SizedBox(height: 8),
        Container(
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
    );
  }
}
