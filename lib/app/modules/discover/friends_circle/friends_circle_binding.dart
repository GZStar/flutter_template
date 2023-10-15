import 'package:get/get.dart';

import 'friends_circle_controller.dart';

class FriendsCirlcelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FriendsCircleController>(() => FriendsCircleController());
  }
}
