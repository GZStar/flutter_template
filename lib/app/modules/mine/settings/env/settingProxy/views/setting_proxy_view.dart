import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/setting_proxy_controller.dart';

class SettingProxyView extends GetView<SettingProxyController> {
  const SettingProxyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('代理地址设置'),
          centerTitle: true,
          automaticallyImplyLeading: false),
      body: WillPopScope(child: getContentBody(), onWillPop: () async => false),
    );
  }

  Widget getContentBody() {
    return Column(
      children: [
        _topContent(),
        _setLocalHost(),
        _setPort(),
        _tipContent(),
        _buttonWidget()
      ],
    );
  }

  Widget _topContent() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Text(controller.proxy),
    );
  }

  Widget _setLocalHost() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          const Text('地址：'),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: TextField(
                controller: controller.localHostTextController,
                maxLines: 1,
                style: const TextStyle(fontSize: 15.0),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    hintText: '请输入...'
                    // fillColor: themeData.colorScheme.surfaceVariant,
                    )),
          )),
        ],
      ),
    );
  }

  Widget _setPort() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          const Text('端口：'),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: TextField(
                controller: controller.portTextController,
                maxLines: 1,
                style: const TextStyle(fontSize: 15.0),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    hintText: '请输入...'
                    // fillColor: themeData.colorScheme.surfaceVariant,
                    )),
          )),
        ],
      ),
    );
  }

  Widget _tipContent() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: const Text(
        '温馨提示：保存好代理地址与端口后，需要重新启动APP才可生效。',
        style: TextStyle(color: Colors.red),
      ),
    );
  }

  Widget _buttonWidget() {
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
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red)),
              onPressed: () {
                controller.onCleanButtonClick();
              },
              child: const Text('清空代理',
                  style: TextStyle(color: Colors.white, fontSize: 15)),
            ),
          ),
        ],
      ),
    );
  }
}
