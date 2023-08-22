import 'package:easy_refresh/easy_refresh.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatController extends GetxController with GetTickerProviderStateMixin {
  //TODO: Implement ChatController

  final inputHeight = 216.h;
  final emojiContainerHeight = 850.h;

  final listenable = IndicatorStateListenable();
  late final TextEditingController inputController;
  late final EasyRefreshController refreshcontroller;
  late final ScrollController scrollController;

  FocusNode focusNode = FocusNode();
  final editKey = GlobalKey();

  var count = 1;
  var isShowEmojiContainer = false;
  var isShowSendButton = false;

  final List<MessageEntity> receiverMessages = [
    MessageEntity(
      own: true,
      msg: "It's first!",
    ),
    MessageEntity(
      own: false,
      img: 'assets/images/wechat/discover/friends/wx_img12.JPG',
      msg: "My test",
    ),
  ];

  final List<MessageEntity> historyMessages = [];

  @override
  void onInit() {
    super.onInit();

    scrollController = ScrollController();
    scrollController.addListener(() {});

    refreshcontroller = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );

    inputController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    inputController.dispose();
    refreshcontroller.dispose();

    super.onClose();
  }

  void loadHistory() async {
    Future.delayed(const Duration(seconds: 2), () {
      historyMessages.addAll([
        MessageEntity(
          own: true,
          msg: "It's good!",
        ),
        MessageEntity(
          own: true,
          msg: "It's own message!",
          img: 'assets/images/wechat/discover/friends/wx_img13.JPG',
        ),
        MessageEntity(
          own: false,
          img: 'assets/images/wechat/discover/friends/wx_img12.JPG',
          msg: "History message ${count}",
        ),
      ]);

      refreshcontroller.finishRefresh();

      update();
    });

    Future.delayed(const Duration(seconds: 3), () {
      receiverMessages.addAll([
        MessageEntity(
          own: true,
          msg: "It's good!",
          img: 'assets/images/wechat/discover/friends/wx_img14.JPG',
        ),
        MessageEntity(
          own: false,
          img: 'assets/images/wechat/discover/friends/wx_img9.JPG',
          msg: "new message ${count}",
        ),
      ]);
      update();
    });

    count++;
  }

  void onSend() {
    if (inputController.text.isEmpty) {
      return;
    }

    receiverMessages.add(MessageEntity(
      own: true,
      msg: inputController.text.trim(),
    ));
    inputController.text = '';

    update();
    scrollToBottom(duration: 0);
  }

  void scrollToBottom({int duration = 650}) {
    Future.delayed(Duration(milliseconds: duration), () {
      // 页面滑动到最底部
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    });
  }

  void showKeyboard() => focusNode.requestFocus();
  void hideKeyboard() => focusNode.unfocus();

  void toggleEmojiKeyboardContainer() {
    if (isShowEmojiContainer) {
      // showKeyboard();
      hideEmojiContainer();
    } else {
      hideKeyboard();
      showEmojiContainer();
    }
  }

  void hideEmojiContainer() {
    isShowEmojiContainer = false;
    update();
  }

  void showEmojiContainer() {
    isShowEmojiContainer = true;
    update();
  }

  void checkTextFieldEmpty(value) {
    if (value.isNotEmpty) {
      isShowSendButton = true;
    } else {
      isShowSendButton = false;
    }
    update();
  }

  void _updateTextEditingValue(TextEditingValue value) {
    (editKey.currentState as TextSelectionGestureDetectorBuilderDelegate)
        .editableTextKey
        .currentState
        ?.userUpdateTextEditingValue(value, SelectionChangedCause.keyboard);

    if (!isShowSendButton) {
      isShowSendButton = false;
      update();
    }
  }

  void onEmojiSelected(Emoji emoji) {
    print('_onEmojiSelected: ${emoji.emoji}');

    if (inputController.selection.base.offset < 0) {
      _updateTextEditingValue(TextEditingValue(
        text: inputController.text + emoji.emoji,
      ));
      return;
    }

    final selection = inputController.selection;
    final newText = inputController.text
        .replaceRange(selection.start, selection.end, emoji.emoji);
    final emojiLength = emoji.emoji.length;
    _updateTextEditingValue(TextEditingValue(
        text: newText,
        selection: selection.copyWith(
          baseOffset: selection.start + emojiLength,
          extentOffset: selection.start + emojiLength,
        )));
  }

  void onEmojiBackspacePressed() {
    print('_onBackspacePressed');
    if (inputController.selection.base.offset < 0) {
      return;
    }

    final selection = inputController.value.selection;
    final text = inputController.value.text;
    final newTextBeforeCursor =
        selection.textBefore(text).characters.skipLast(1).toString();
    _updateTextEditingValue(TextEditingValue(
        text: newTextBeforeCursor + selection.textAfter(text),
        selection: TextSelection.fromPosition(
            TextPosition(offset: newTextBeforeCursor.length))));
  }
}

class MessageEntity {
  bool own;
  String? msg;
  String? img;

  MessageEntity({
    required this.own,
    required this.msg,
    this.img,
  });
}
