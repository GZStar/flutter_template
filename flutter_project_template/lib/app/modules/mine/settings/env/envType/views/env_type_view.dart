import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../../common/widgets/set_cell.dart';
import '../../../../../../routes/mine_routes.dart';
import '../controllers/env_type_controller.dart';

class EnvTypeView extends GetView<EnvTypeController> {
  const EnvTypeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print('setting view build');
    return Scaffold(
      appBar: AppBar(
        title: const Text('环境类型'),
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
            title: '服务器环境设置',
            clickCallBack: () {
              Get.toNamed(MineRoutes.envSetting);
            }),
        CommonSetCell(
            title: '代理地址设置',
            hiddenLine: true,
            clickCallBack: () {
              Get.toNamed(MineRoutes.proxySetting);
            }),
      ],
    );
  }
}
