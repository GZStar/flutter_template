import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_template/app/common/widgets/toast.dart';
import 'package:get/get.dart';

class ChatController extends GetxController with GetTickerProviderStateMixin {
  //TODO: Implement ChatController
  final listenable = IndicatorStateListenable();
  late final TextEditingController inputController;
  late final EasyRefreshController refreshcontroller;
  ScrollController scrollController = ScrollController();

  bool firstAutoscrollExecuted = false;
  bool shouldAutoscroll = false;

  var shrinkWrap = false.obs;
  var count = 1;
  double? viewportDimension;

  var msg = "".obs;
  var showEmoji = false.obs;
  var oldShowEmoji = false.obs;

  List categoryList = [Icons.emoji_emotions, Icons.star];
  late TabController tabController;

  final List<MessageEntity> receiverMessages = [
    MessageEntity(
      own: true,
      msg: "It's good!",
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
    tabController = TabController(length: categoryList.length, vsync: this);

    refreshcontroller = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );

    inputController = TextEditingController.fromValue(TextEditingValue(
        text: msg.value, //判断keyword是否为空
        // 保持光标在最后
        selection: TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream, offset: msg.value.length))));
    // inputController.addListener(() {
    //   textNotEmpty.value = inputController.text.isNotEmpty;
    //   inputController.text = msg.value;

    //   scrollToBottom();
    // });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    inputController.dispose();
    refreshcontroller.dispose();
    tabController.dispose();

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
      msg: inputController.text,
    ));
    inputController.clear();

    update();
    scrollToBottom();
  }

  void sendMsg(String message, {String pic = "", int media = 1}) {
    if ((message == "") && pic == "") {
      showToast("请输入内容！");
      return;
    }

    receiverMessages.add(MessageEntity(
      own: true,
      msg: message,
    ));

    msg.value = "";
    inputController.clear();

    update();
    scrollToBottom(duration: 0);
  }

  void scrollToBottom({int duration = 650}) {
    // 页面滑动到最底部
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   scrollController.animateTo(
    //     scrollController.position.maxScrollExtent,
    //     duration: const Duration(milliseconds: 300),
    //     curve: Curves.easeOut,
    //   );
    // });

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
