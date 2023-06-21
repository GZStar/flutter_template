import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/base/base_view.dart';
import '../../../../common/widgets/common_widget.dart';
import '../../../../common/widgets/set_cell.dart';
import '../controllers/language_setting_controller.dart';

class LanguageSettingView extends BaseView<LanguageSettingController> {
  // final checkImage = Image.asset(
  //   'assets/images/wechat/mine/ic_settings.png',
  //   height: 20,
  // );
  final checkImage = Icon(Icons.check);

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return CommonWidget.appBar('set_language'.tr);
  }

  @override
  Widget body(BuildContext context) {
    return getContentBody();
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
              ? checkImage
              : const SizedBox(),
          clickCallBack: () {
            controller.selectLanguage(index);
          },
        ));
  }
}
