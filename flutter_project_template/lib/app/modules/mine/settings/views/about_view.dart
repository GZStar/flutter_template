import 'package:flutter/material.dart';
import 'package:flutter_project_template/app/common/widgets/toast.dart';
import 'package:flutter_project_template/app/routes/mine_routes.dart';
import 'package:get/get.dart';

import '../../../../common/base/base_view.dart';
import '../../../../common/widgets/common_widget.dart';
import '../../../../common/widgets/set_cell.dart';
import '../../../../data/local/store/config_store.dart';
import '../controllers/about_controller.dart';

class AboutView extends BaseView<AboutController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return CommonWidget.appBar('about'.tr);
  }

  @override
  Widget body(BuildContext context) {
    // return getContentBody();
    return Column(
      children: [
        Expanded(child: getContentBody()),
        const SizedBox(height: 5),
        Text(
          '©2016–2022 MyDemo All rights reserved',
          textAlign: TextAlign.center,
          style: Get.theme.textTheme.titleMedium,
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  // cell
  Widget getContentBody() {
    return ListView(
      children: <Widget>[
        headerLogoWidget(),
        CommonSetCell(
            title: '去评分'.tr,
            clickCallBack: () {
              showToast('去评分');
            }),
        CommonSetCell(
            title: '功能介绍'.tr,
            clickCallBack: () {
              showToast('功能介绍');
            }),
        CommonSetCell(title: '意见反馈'.tr, clickCallBack: () {}),
        CommonSetCell(
            title: '重置引导页'.tr,
            clickCallBack: () {
              ConfigStore.to.isFirstOpen = false;
              showToast('引导页已重置，重新打开应用即可展示引导页');
            }),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget headerLogoWidget() {
    return Column(children: <Widget>[
      const SizedBox(height: 50),
      InkWell(
        child: Image.asset(
          'assets/images/other/ic_demo1.png',
          width: 80,
          height: 80,
        ),
        onDoubleTap: () {
          Get.toNamed(MineRoutes.envSetting);
        },
      ),
      const SizedBox(height: 20),
      Obx(() => Text(controller.currentAppName.value,
          style: const TextStyle(fontSize: 20))),
      const SizedBox(height: 8),
      Obx(() => Text('Version：${controller.currentVersion.value}')),
      const SizedBox(height: 20),
    ]);
  }
}
