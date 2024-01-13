import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_template/app/common/style/app_colors.dart';

import 'package:get/get.dart';

import '../controllers/test_hide_status_bar_controller.dart';

class TestHideStatusBarView extends GetView<TestHideStatusBarController> {
  const TestHideStatusBarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: [SystemUiOverlay.bottom]);

    return Container(
      color: AppColors.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
              child: Container(
                width: 100,
                height: 40,
                color: Colors.blue,
              ),
              onTap: () {
                print("click widget action");
                Get.back();
              }),
          const Text(
            'TestHideStateBarView is working',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );

    // return Stack(
    //   children: [
    //     const Scaffold(
    //       body: Center(
    //         child: Text('Content'),
    //       ),
    //     ),
    //     // Status bar tap override
    //     Positioned(
    //       top: 0,
    //       left: 0,
    //       right: 0,
    //       height: 30,
    //       child: Container(
    //         color: Colors.blue,
    //         child: GestureDetector(
    //           onTap: () {
    //             print("click action");
    //           },
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }
}
