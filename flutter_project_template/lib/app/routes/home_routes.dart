import 'package:flutter_project_template/app/modules/chat/bindings/chat_binding.dart';
import 'package:flutter_project_template/app/modules/chat/views/chat_view.dart';
import 'package:get/get.dart';

abstract class HomeRoutes {
  // chat
  static const chat = '/chat';
}

class HomePages {
  static final routes = <GetPage>[
    GetPage(
        name: HomeRoutes.chat, page: () => ChatView(), binding: ChatBinding()),
  ];
}
