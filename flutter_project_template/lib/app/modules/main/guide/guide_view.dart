import 'dart:ui' as ui show window;

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../common/widgets/banner.dart';
import 'guide_controller.dart';

class GuideView extends GetView<GuideController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: Get.height,
        child: Stack(
          children: [
            getBanner(),
            Obx(() {
              return controller.isLastPage.value
                  ? const SizedBox()
                  : getSkipButton();
            }),
            Obx(() {
              return controller.isLastPage.value
                  ? getStartButton()
                  : const SizedBox();
            }),
          ],
        ),
      ),
    );
  }

  Widget getBanner() {
    return BannerWidget(
      Get.height,
      controller.bannerList,
      isAutoScroll: false,
      isCycle: false,
      isShowCircle: true,
      bannerPress: (index, item, type) {
        // 点击
        print('select index = $index');
      },
      pageChanged: (position) {
        controller.pageChanged(position);
      },
    );
  }

  Widget getSkipButton() {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);

    return Positioned(
      top: mediaQuery.padding.top + 18.0,
      right: 30,
      child: ElevatedButton(
          onPressed: (() {
            controller.closeView();
          }),
          child: const Text('Skip')),
    );
  }

  Widget getStartButton() {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);

    return Center(
      child: Positioned(
        bottom: mediaQuery.padding.bottom + 50.0,
        child: ElevatedButton(
            onPressed: (() {
              controller.closeView();
            }),
            child: const Text('Start')),
      ),
    );
  }
}
