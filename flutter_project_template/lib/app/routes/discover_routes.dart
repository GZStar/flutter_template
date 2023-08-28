import 'package:flutter_project_template/app/modules/discover/friends_public/bindings/friends_public_binding.dart';
import 'package:flutter_project_template/app/modules/discover/friends_public/views/friends_public_view.dart';
import 'package:get/get.dart';

import '../modules/discover/friends_circle/friends_circle_binding.dart';
import '../modules/discover/friends_circle/friends_circle_view.dart';

abstract class DiscoverRoutes {
  // 朋友圈
  static const friendsCircle = '/friends/circle';
  static const friendsPublic = '/friends/public';
}

class DiscoverPages {
  static final routes = <GetPage>[
    GetPage(
        name: DiscoverRoutes.friendsCircle,
        page: () => const FriendsCircleView(),
        binding: FriendsCirlcelBinding()),
    GetPage(
        name: DiscoverRoutes.friendsPublic,
        page: () => const FriendsPublicView(),
        binding: FriendsPublicBinding(),
        transition: Transition.downToUp),
  ];
}
