import 'package:flutter/material.dart';
import 'package:flutter_project_template/app/common/utils/qr_code_utils.dart';

import 'package:get/get.dart';

import '../controllers/user_qr_code_controller.dart';

class UserQrCodeView extends GetView<UserQrCodeController> {
  const UserQrCodeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Widget imageWidget = QrCodeUtils.createQRCode(
        'https://github.com/flutter', Get.width * 2 / 3,
        image: const AssetImage('assets/images/other/lufei.png'));

    return Scaffold(
      appBar: AppBar(
        title: const Text('二维码'),
        centerTitle: true,
      ),
      body: Center(
        child: imageWidget,
      ),
    );
  }
}
