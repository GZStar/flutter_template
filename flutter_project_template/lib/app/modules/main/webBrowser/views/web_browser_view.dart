import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../common/widgets/common_widget.dart';
import '../controllers/web_browser_controller.dart';

class WebBrowserView extends GetView<WebBrowserController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final bool canGoBack = await controller.webViewController.canGoBack();
        if (canGoBack) {
          // 网页可以返回时，优先返回上一页
          await controller.webViewController.goBack();
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Obx(() => Text(controller.title.value)),
        ),
        body: Stack(
          children: [
            WebViewWidget(controller: controller.webViewController),
            if (controller.progressValue.value != 100)
              LinearProgressIndicator(
                value: controller.progressValue.value / 100,
                backgroundColor: Colors.transparent,
                minHeight: 2,
              )
            else
              const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
