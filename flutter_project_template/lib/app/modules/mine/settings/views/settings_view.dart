import 'package:flutter/material.dart';
import 'package:flutter_project_template/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../../../common/base/base_view.dart';
import '../../../../common/widgets/common_widget.dart';
import '../../../../common/widgets/set_cell.dart';
import '../../../../data/local/store/user_store.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends BaseView<SettingsController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return CommonWidget.appBar('settings'.tr);
  }

  @override
  Widget body(BuildContext context) {
    return getContentBody();
  }

  // cell
  Widget getContentBody() {
    return ListView(
      children: <Widget>[
        CommonSetCell(
            title: 'set_language'.tr,
            clickCallBack: () {
              Get.toNamed(AppRoutes.languageSetting);
            }),
        CommonSetCell(
            title: 'appearance'.tr,
            hiddenLine: true,
            clickCallBack: () {
              Get.toNamed(AppRoutes.themeSetting);
            }),
        const SizedBox(height: 8),
        CommonSetCell(title: 'clear_cache'.tr, clickCallBack: () {}),
        CommonSetCell(title: '网络检测'.tr, clickCallBack: () {}),
        CommonSetCell(
          title: 'about'.tr,
          text: 'v2.0.1',
          hiddenLine: true,
          clickCallBack: () {
            Get.toNamed(AppRoutes.about);
          },
        ),
        const SizedBox(height: 8),
        Container(
          height: 50,
          color: Colors.white,
          child: TextButton(
            onPressed: () {
              UserStore.to.onLogout();
            },
            child: Text('logout'.tr,
                style: const TextStyle(color: Colors.red, fontSize: 20)),
          ),
        ),
      ],
    );
  }
}
