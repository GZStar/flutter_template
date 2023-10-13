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
        color: Colors.blue,
        height: Get.height,
        child: Stack(
          alignment: Alignment.center,
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

  // banner() {
  //   return Swiper(
  //     itemCount: controller.imageUrls.length,
  //     autoplay: false,
  //     loop: false,
  //     itemBuilder: (BuildContext context, int index) {
  //       return Image.asset(controller.imageUrls[index]);
  //     },
  //     //自定义指示器
  //     pagination: const SwiperPagination(
  //         alignment: Alignment.bottomCenter,
  //         margin: EdgeInsets.only(bottom: 100),
  //         builder: DotSwiperPaginationBuilder(
  //             color: Colors.white60, size: 6, activeSize: 12)),
  //   );
  // }

  Widget getSkipButton() {
    MediaQueryData mediaQuery = MediaQueryData.fromView(ui.window);

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
    MediaQueryData mediaQuery = MediaQueryData.fromView(ui.window);

    return Positioned(
      bottom: mediaQuery.padding.bottom + 50.0,
      child: ElevatedButton(
          onPressed: (() {
            controller.closeView();
          }),
          child: const Text('Start')),
    );
  }
}
