import 'package:easy_refresh/easy_refresh.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_template/app/routes/main_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../../../common/utils/image_picker_utils.dart';
import '../../../common/utils/permission_utils.dart';
import '../../../common/widgets/photo_browser.dart';

class ChatController extends GetxController with GetTickerProviderStateMixin {
  //TODO: Implement ChatController

  final inputHeight = 216.h;
  final emojiContainerHeight = 307.0;

  late final TextEditingController inputController;
  late final EasyRefreshController refreshcontroller;
  late final ScrollController scrollController;

  FocusNode focusNode = FocusNode();
  final editKey = GlobalKey();

  var count = 1;
  var isShowEmojiContainer = false;
  var isShowSendButton = false;

  final List<MessageEntity> historyMessages = [
    MessageEntity(
      own: true,
      msg: "It's good! 1",
    ),
    MessageEntity(
        own: false,
        img: 'assets/images/wechat/discover/friends/wx_img12.JPG',
        msg: "",
        mediaType: 2),
    MessageEntity(
      own: false,
      msg: "send 1",
    ),
    MessageEntity(
      own: true,
      msg: "It's good! 2",
    ),
    MessageEntity(
      own: false,
      msg: "send 2",
    ),
    MessageEntity(
        own: false,
        img: 'assets/images/wechat/discover/friends/wx_img16.JPG',
        msg: "",
        mediaType: 2),
    MessageEntity(
      own: true,
      msg: "It's good! 3",
    ),
    MessageEntity(
        own: false,
        img: 'assets/images/wechat/discover/friends/wx_img15.JPG',
        msg: "",
        mediaType: 2),
    MessageEntity(
      own: true,
      msg: "It's good! 4",
    ),
    MessageEntity(
        own: false,
        img: 'assets/images/wechat/discover/friends/wx_img14.JPG',
        msg: "",
        mediaType: 2),
    MessageEntity(
      own: true,
      msg: "It's good! 5",
    ),
    MessageEntity(
        own: false,
        img: 'assets/images/wechat/discover/friends/wx_img13.JPG',
        msg: "",
        mediaType: 2),
  ];
  final List<MessageEntity> newMessages = [];

  double anchorData = 0; //历史内容高度比例
  bool isFistLoad = true;
  final listenable = IndicatorStateListenable();

  void _onHeaderChange() {
    final state = listenable.value;
    if (state != null) {
      final position = state.notifier.position;
      final viewportDimension = position.viewportDimension;
      final minScrollExtent = position.minScrollExtent;
      print('minScrollExtent = ${minScrollExtent}');
      print('viewportDimension = ${viewportDimension}');

      if (minScrollExtent < 0 && isFistLoad) {
        final tempHeight = minScrollExtent.abs();
        print('tempHeight = ${tempHeight}');
        final tempData = tempHeight / viewportDimension;
        print('anchorData = ${tempData}');
        if (tempData > 1) {
          anchorData = 1;
        } else if (tempData < 0) {
          anchorData = 0;
        } else {
          anchorData = tempData;
        }
        isFistLoad = false;
        update();
      }
      print("============================");
    }
  }

  @override
  void onInit() {
    super.onInit();

    listenable.addListener(_onHeaderChange);

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
            msg: "",
            img: 'assets/images/wechat/discover/friends/wx_img13.JPG',
            mediaType: 2),
        MessageEntity(own: false, msg: "History message ${count}"),
        MessageEntity(
            own: false,
            img: 'assets/images/wechat/discover/friends/wx_img12.JPG',
            msg: "History message ${count}",
            mediaType: 2),
      ]);

      refreshcontroller.finishRefresh();

      update();
    });

    Future.delayed(const Duration(seconds: 3), () {
      newMessages.addAll([
        MessageEntity(
            own: true,
            msg: "",
            img: 'assets/images/wechat/discover/friends/wx_img14.JPG',
            mediaType: 2),
        MessageEntity(
          own: false,
          msg: "new message ${count}",
        ),
        MessageEntity(
            own: false,
            img: 'assets/images/wechat/discover/friends/wx_img9.JPG',
            msg: "new message ${count}",
            mediaType: 2),
      ]);
      update();
    });

    count++;
  }

  void onSend() {
    if (inputController.text.isEmpty) {
      return;
    }

    newMessages.add(MessageEntity(
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

  void onMessageViewClick() {
    if (isShowEmojiContainer) {
      hideEmojiContainer();
    }
    focusNode.unfocus();
  }

  void toggleEmojiKeyboardContainer() {
    if (isShowEmojiContainer) {
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

  void openImagePickerView(context) async {
    if (isShowEmojiContainer) {
      isShowEmojiContainer = false;
      update();
    }

    if (await PermissionsUtils.getPhotosPermission() == false) {
      return;
    }

    final List<AssetEntity>? fileList =
        await ImagePickerUtils.pickImage(context);

    if (fileList != null) {
      for (var entity in fileList) {
        AssetType type = entity.type;
        int mediaType = 1;
        if (type == AssetType.image) {
          mediaType = 4;
          newMessages.add(MessageEntity(
              own: true, msg: '', mediaType: mediaType, asset: entity));
        } else if (type == AssetType.video) {
          mediaType = 3;
          newMessages.add(MessageEntity(
              own: true, msg: '', mediaType: mediaType, asset: entity));
        }

        update();
        scrollToBottom(duration: 300);
      }
    }
  }

  void onMessageTap(MessageEntity message) {
    if (message.mediaType == 3) {
      Get.toNamed(MainRoutes.video, arguments: {'asset': message.asset});
    } else if (message.mediaType == 2) {
      Get.to(
          () => PhotoBrowser(
                imgDataArr: [message.img],
                index: 0,
                onLongPress: () {},
              ),
          transition: Transition.zoom,
          fullscreenDialog: true);
    } else if (message.mediaType == 4) {
      Get.to(
          () => PhotoBrowser(
                imgDataArr: [message.asset],
                index: 0,
                isAssetImage: true,
                onLongPress: () {},
              ),
          transition: Transition.zoom,
          fullscreenDialog: true);
    }
  }
}

class MessageEntity {
  bool own;
  String? msg;
  String? img;
  int? mediaType;
  AssetEntity? asset;

  MessageEntity({
    required this.own,
    required this.msg,
    this.img,
    this.mediaType,
    this.asset,
  });
}
