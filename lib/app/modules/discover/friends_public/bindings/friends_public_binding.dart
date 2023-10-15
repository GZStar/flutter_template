import 'package:get/get.dart';

import '../controllers/friends_public_controller.dart';

class FriendsPublicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FriendsPublicController>(
      () => FriendsPublicController(),
    );
  }
}
