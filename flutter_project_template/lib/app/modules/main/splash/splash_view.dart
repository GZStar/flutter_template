import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/style/app_colors.dart';
import 'splash_controller.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue,
      child: Container(
        color: Colors.yellow,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.hourglass_bottom,
              color: AppColors.primaryColor,
              size: 30.0,
            ),
            Text(
              'loading...',
              style: TextStyle(fontSize: 30.0),
            ),
          ],
        ),
      ),
    );
  }
}
