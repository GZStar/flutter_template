import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/chat_controller.dart';

class BottomChatFieldView extends GetView<ChatController> {
  const BottomChatFieldView({Key? key}) : super(key: key);

  Widget _bottomSendBar(context) {
    final themeData = Theme.of(context);
    return Container(
      color: themeData.colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                controller.focusNode.unfocus();
                controller.openImagePickerView(context);
              },
              color: themeData.colorScheme.primary,
              icon: const Icon(Icons.add_circle_outline),
              visualDensity: VisualDensity.compact,
            ),
            IconButton(
              color: themeData.colorScheme.primary,
              icon: const Icon(Icons.tag_faces),
              visualDensity: VisualDensity.compact,
              onPressed: () {
                controller.scrollToBottom(duration: 200);
                controller.toggleEmojiKeyboardContainer();
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: TextField(
                  textInputAction: TextInputAction.send,
                  key: controller.editKey,
                  focusNode: controller.focusNode,
                  controller: controller.inputController,
                  minLines: 1,
                  maxLines: 1,
                  // style: const TextStyle(fontSize: 15.0),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    // fillColor: themeData.colorScheme.surfaceVariant,
                    prefixIcon: const Icon(Icons.abc),
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.onSend();
                      },
                      icon: GetBuilder<ChatController>(builder: (controller) {
                        return Icon(controller.isShowSendButton
                            ? Icons.send
                            : Icons.keyboard_voice_outlined);
                      }),
                    ),
                  ),
                  onSubmitted: (value) {
                    controller.onSend();
                  },
                  onTap: () {
                    if (controller.isShowEmojiContainer) {
                      controller.isShowEmojiContainer = false;
                      controller.scrollToBottom();
                    }
                  },
                  onChanged: (value) {
                    controller.checkTextFieldEmpty(value);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emojiContext(context) {
    return Visibility(
      visible: controller.isShowEmojiContainer,
      child: Container(
        height: controller.emojiContainerHeight,
        child: EmojiPicker(
            onEmojiSelected: ((category, emoji) {
              controller.onEmojiSelected(emoji);
            }),
            onBackspacePressed: controller.onEmojiBackspacePressed,
            config: Config(
              columns: 7,
              // Issue: https://github.com/flutter/flutter/issues/28894
              emojiSizeMax: 32 * (GetPlatform.isIOS ? 1.30 : 1.0),
              verticalSpacing: 0,
              horizontalSpacing: 0,
              gridPadding: EdgeInsets.zero,
              initCategory: Category.RECENT,
              bgColor: const Color(0xFFF2F2F2),
              indicatorColor: Colors.blue,
              iconColor: Colors.grey,
              iconColorSelected: Colors.blue,
              backspaceColor: Colors.blue,
              skinToneDialogBgColor: Colors.white,
              skinToneIndicatorColor: Colors.grey,
              enableSkinTones: true,
              recentTabBehavior: RecentTabBehavior.RECENT,
              recentsLimit: 28,
              replaceEmojiOnLimitExceed: false,
              noRecents: const Text(
                'No Recents',
                style: TextStyle(fontSize: 20, color: Colors.black26),
                textAlign: TextAlign.center,
              ),
              loadingIndicator: const SizedBox.shrink(),
              tabIndicatorAnimDuration: kTabScrollDuration,
              categoryIcons: const CategoryIcons(),
              buttonMode: ButtonMode.MATERIAL,
              checkPlatformCompatibility: true,
            )),
      ),
    );
  }

  Widget _emojiAnimated(context) {
    return GetBuilder<ChatController>(builder: (controller) {
      return AnimatedContainer(
          curve: Curves.easeOutQuad,
          duration: const Duration(milliseconds: 200),
          height: controller.isShowEmojiContainer
              ? controller.emojiContainerHeight
              : 0,
          child: _emojiContext(context));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _bottomSendBar(context),
        _emojiAnimated(context),
      ],
    );
  }
}
