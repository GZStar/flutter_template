import 'package:flutter_project_template/app/data/local/store/config_store.dart';
import 'package:get/get.dart';

import '../../../common/widgets/banner.dart';
import '../../../data/local/store/user_store.dart';
import '../../../routes/app_pages.dart';

class GuideController extends GetxController {
  List<BannerItem> bannerList = [];
  var isLastPage = false.obs;
  final imageUrls = [
    'assets/images/guide/guide1.png',
    'assets/images/guide/guide2.png',
    'assets/images/guide/guide3.png',
    'assets/images/guide/guide4.png',
  ];

  @override
  void onInit() {
    super.onInit();

    initDefaultBanner();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void initDefaultBanner() {
    final urls = [
      'assets/images/guide/guide1.png',
      'assets/images/guide/guide2.png',
      'assets/images/guide/guide3.png',
      'assets/images/guide/guide4.png',
    ];

    for (var i = 0; i < urls.length; i++) {
      BannerItem item = BannerItem.defaultBannerItem(urls[i], '', 'local');
      bannerList.add(item);
    }
  }

  void pageChanged(int index) {
    if (index == bannerList.length - 1) {
      isLastPage.value = true;
    } else {
      isLastPage.value = false;
    }
  }

  void closeView() async {
    ConfigStore.to.saveAlreadyOpen();

    if (UserStore.to.isLogin == true) {
      return Get.offAllNamed(AppRoutes.mainTabbar);
    } else {
      return Get.offAllNamed(AppRoutes.login);
    }
  }
}
