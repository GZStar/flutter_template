import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/set_cell.dart';
import '../controllers/theme_setting_controller.dart';

class ThemeSettingView extends GetView<ThemeSettingController> {
  const ThemeSettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('appearance'.tr),
        centerTitle: true,
      ),
      body: getContentBody(),
    );
  }

  Widget getContentBody() {
    return ListView.builder(
      itemBuilder: itemBuilder,
      itemCount: controller.themes.length,
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    return Obx(() => CommonSetCell(
          title: controller.themes[index].name,
          hiddenArrow: true,
          hiddenLine: (index == controller.themes.length - 1) ? true : false,
          rightWidget: (index == controller.selectIndex.value)
              ? const Icon(Icons.check)
              : const SizedBox(),
          clickCallBack: () {
            controller.selectTheme(index);
          },
        ));
  }
}
