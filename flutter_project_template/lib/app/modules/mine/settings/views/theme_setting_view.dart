import 'package:flutter/material.dart';
import 'package:flutter_project_template/app/common/base/base_view.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/common_widget.dart';
import '../../../../common/widgets/set_cell.dart';
import '../controllers/theme_setting_controller.dart';

class ThemeSettingView extends BaseView<ThemeSettingController> {
  final checkImage = Icon(Icons.check);

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return CommonWidget.appBar('appearance'.tr);
  }

  @override
  Widget body(BuildContext context) {
    return getContentBody();
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
              ? checkImage
              : const SizedBox(),
          clickCallBack: () {
            controller.selectTheme(index);
          },
        ));
  }
}
