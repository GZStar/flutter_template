import 'package:flutter/material.dart';
import 'package:flutter_project_template/app/common/widgets/toast.dart';
import 'package:flutter_project_template/app/routes/mine_routes.dart';
import 'package:get/get.dart';

import '../../../../common/values/storage_key.dart';
import '../../../../common/widgets/set_cell.dart';
import '../../../../data/local/store/storage_service.dart';
import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('about'.tr),
        centerTitle: true,
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        Expanded(child: getContentBody()),
        const SizedBox(height: 5),
        SafeArea(
          child: Text(
            '©2016–2022 MyDemo All rights reserved',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
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
            bgColor: Colors.red,
            clickCallBack: () {
              showToast('功能介绍');
            }),
        CommonSetCell(title: '投诉维权'.tr, clickCallBack: () {}),
        CommonSetCell(
            title: '重置引导页'.tr,
            clickCallBack: () {
              StorageService.to.setBool(StorageKeys.deviceFirstOpen, false);
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
          'assets/images/common/icon.png',
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
