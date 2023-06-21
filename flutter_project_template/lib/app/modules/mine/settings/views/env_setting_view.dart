import 'package:flutter/material.dart';
import 'package:flutter_project_template/app/common/base/base_view.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/common_widget.dart';
import '../../../../common/widgets/set_cell.dart';
import '../controllers/env_setting_controller.dart';

class EnvSettingView extends BaseView<EnvSettingController> {
  final checkImage = Icon(Icons.check);

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return CommonWidget.appBar('环境设置'.tr, isBackButtonEnabled: false);
  }

  @override
  Widget body(BuildContext context) {
    return WillPopScope(child: getContentBody(), onWillPop: () async => false);
  }

  Widget getContentBody() {
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
          itemBuilder: itemBuilder,
          itemCount: controller.envs.length + 1,
        ))
      ],
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    if (index == controller.envs.length) {
      return buttonWidget();
    }
    return Obx(() => CommonSetCell(
          title: controller.envs[index],
          hiddenArrow: true,
          hiddenLine: (index == controller.envs.length - 1) ? true : false,
          rightWidget: (index == controller.selectIndex.value)
              ? checkImage
              : const SizedBox(),
          clickCallBack: () {
            controller.selectTheme(index);
          },
        ));
  }

  Widget buttonWidget() {
    return Container(
      height: 100,
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue)),
              onPressed: () {
                controller.onCancelButtonClick();
              },
              child: Text('cancel'.tr,
                  style: const TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ),
          Expanded(
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red)),
              onPressed: () {
                controller.onSaveButtonClick();
              },
              child: Text('save'.tr,
                  style: const TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ),
        ],
      ),
    );
  }
}
