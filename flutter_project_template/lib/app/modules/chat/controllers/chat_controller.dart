import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  //TODO: Implement ChatController
  final listenable = IndicatorStateListenable();
  late final TextEditingController inputController;

  var shrinkWrap = false.obs;
  var textNotEmpty = false.obs;
  double? viewportDimension;

  final List<MessageEntity> messages = [
    MessageEntity(
      own: true,
      msg: "It's good!",
    ),
    MessageEntity(
      own: false,
      img: 'assets/images/wechat/discover/friends/wx_img12.JPG',
      msg: "My test",
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();

    inputController = TextEditingController();
    inputController.addListener(() {
      textNotEmpty.value = inputController.text.isNotEmpty;
    });
    listenable.addListener(onHeaderChange);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    listenable.removeListener(onHeaderChange);
    inputController.dispose();
    super.onClose();
  }

  void onHeaderChange() {
    final state = listenable.value;
    if (state != null) {
      final position = state.notifier.position;
      viewportDimension ??= position.viewportDimension;
      final shrinkWrap1 = state.notifier.position.maxScrollExtent == 0;
      if (shrinkWrap.value != shrinkWrap1 &&
          viewportDimension == position.viewportDimension) {
        shrinkWrap.value = shrinkWrap1;
      }
    }
  }

  void loadHistory() {
    Future.delayed(const Duration(seconds: 2), () {
      messages.addAll([
        MessageEntity(
          own: true,
          msg: "It's good!",
        ),
        MessageEntity(
          own: false,
          img: 'assets/images/wechat/discover/friends/wx_img12.JPG',
          msg: "History message",
        ),
      ]);
    });
  }

  void onSend() {
    if (inputController.text.isEmpty) {
      return;
    }
    messages.insert(
        0,
        MessageEntity(
          own: true,
          msg: inputController.text,
        ));

    inputController.clear();
    // Future(() {
    //   PrimaryScrollController.of(context).jumpTo(0);
    // });
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
