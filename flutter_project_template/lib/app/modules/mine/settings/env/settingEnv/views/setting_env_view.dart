import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../../common/widgets/set_cell.dart';
import '../controllers/setting_env_controller.dart';

class SettingEnvView extends GetView<SettingEnvController> {
  const SettingEnvView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('服务器环境设置'),
          centerTitle: true,
          automaticallyImplyLeading: false),
      body: WillPopScope(child: getContentBody(), onWillPop: () async => false),
    );
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
              ? const Icon(Icons.check)
              : const SizedBox(),
          clickCallBack: () {
            controller.selectTheme(index);
          },
        ));
  }

  Widget buttonWidget() {
    return Container(
      padding: const EdgeInsets.all(15),
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
                  style: const TextStyle(color: Colors.white, fontSize: 15)),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red)),
              onPressed: () {
                controller.onSaveButtonClick();
              },
              child: Text('save'.tr,
                  style: const TextStyle(color: Colors.white, fontSize: 15)),
            ),
          ),
        ],
      ),
    );
  }
}
