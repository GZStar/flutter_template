import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebBrowserController extends GetxController {
  //TODO: Implement WebBrowserController
  var url = "".obs;
  var title = "详情".obs;
  var progressValue = 0.obs;

  late WebViewController webViewController;

  @override
  void onInit() {
    super.onInit();

    url.value = Get.arguments["url"] ?? "https://www.baidu.com";

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
            progressValue.value = progress;
          },
          onPageFinished: (url) async {
            var tempTitle = await webViewController
                .runJavaScriptReturningResult("document.title");
            title.value = tempTitle == '' ? '详情' : tempTitle.toString();
          },
        ),
      )
      ..loadRequest(Uri.parse(url.value));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}