import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MainTabbarController extends GetxController {
  var showCalendarBadge = true.obs;
  var currentIndex = 0.obs;
  late List<Widget> pages;

  static int initialPage = 0;
  final PageController pageController =
      PageController(initialPage: initialPage);

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {}

  @override
  void onInit() {
    super.onInit();
  }

  void onJumpTo(int index) {
    pageController.jumpToPage(index);
    currentIndex.value = index;
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
