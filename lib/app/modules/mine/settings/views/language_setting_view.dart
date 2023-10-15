import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/set_cell.dart';
import '../controllers/language_setting_controller.dart';

class LanguageSettingView extends GetView<LanguageSettingController> {
  const LanguageSettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('set_language'.tr),
        centerTitle: true,
      ),
      body: getContentBody(),
    );
  }

  Widget getContentBody() {
    return ListView.builder(
      itemBuilder: itemBuilder,
      itemCount: controller.languages.length,
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    return Obx(() => CommonSetCell(
          title: controller.languages[index].name,
          hiddenArrow: true,
          hiddenLine: (index == controller.languages.length - 1) ? true : false,
          rightWidget: (index == controller.selectIndex.value)
              ? const Icon(Icons.check)
              : const SizedBox(),
          clickCallBack: () {
            controller.selectLanguage(index);
          },
        ));
  }
}
