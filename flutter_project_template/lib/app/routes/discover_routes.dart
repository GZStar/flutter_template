import 'package:get/get.dart';

import '../modules/discover/friends_circle/friends_circle_binding.dart';
import '../modules/discover/friends_circle/friends_circle_view.dart';

abstract class DiscoverRoutes {
  // 朋友圈
  static const friendsCircle = '/friendsCircle';
}

class DiscoverPages {
  static final routes = <GetPage>[
    GetPage(
        name: DiscoverRoutes.friendsCircle,
        page: () => const FriendsCircleView(),
        binding: FriendsCirlcelBinding()),
  ];
}
