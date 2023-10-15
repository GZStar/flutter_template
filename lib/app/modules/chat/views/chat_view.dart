import 'package:flutter/material.dart';
import 'package:flutter_project_template/app/modules/chat/views/chat_message_view.dart';
import 'package:flutter_project_template/app/routes/mine_routes.dart';

import 'package:get/get.dart';

import '../controllers/chat_controller.dart';
import 'bottom_chat_field_view.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("ChatView build");
    return GestureDetector(
      onTap: () {
        controller.focusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('李四'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                Get.toNamed(MineRoutes.userProfile);
                // controller.loadHistory();
              },
            ),
          ],
        ),
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            const ChatMessageView(),
            _bottomContain(context),
          ],
        ),
      ),
    );
  }

  Widget _bottomContain(context) {
    final mq = MediaQuery.of(context);
    final bottomOffset = mq.viewInsets.bottom + mq.padding.bottom;
    final themeData = Theme.of(context);

    print('bottomOffset = ${bottomOffset}');

    return GetBuilder<ChatController>(
      builder: (controller) {
        return AnimatedContainer(
          color: themeData.colorScheme.primaryContainer,
          padding: const EdgeInsets.only(bottom: 0),
          height: controller.isShowEmojiContainer
              ? controller.emojiContainerHeight + controller.inputHeight
              : bottomOffset + controller.inputHeight,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutQuad,
          child: const BottomChatFieldView(),
        );
      },
    );
  }
}
