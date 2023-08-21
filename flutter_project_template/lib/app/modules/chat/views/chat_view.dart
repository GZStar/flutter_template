import 'dart:math' as math;

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_template/app/common/style/app_colors.dart';
import 'package:flutter_project_template/app/routes/mine_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';

import '../../../common/utils/emoji.dart';
import '../../../common/values/dimens.dart';
import '../../../common/widgets/gz_tab.dart';
import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({Key? key}) : super(key: key);

  Widget _buildMessageItem(
      int index, List<MessageEntity> messages, bool isTopList) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final themeData = Theme.of(context);
        final message = messages[index];
        final maxWidth = math.min(constraints.maxWidth - 124, 400.0);
        Widget? imgWidget;
        Widget? msgWidget;

        bool continuously = false;
        if (isTopList) {
          continuously = index != 0 && messages[index - 1].own == message.own;
        } else {
          continuously = index != (messages.length - 1) &&
              messages[index + 1].own == message.own;
        }
        if (message.img != null) {
          imgWidget = LayoutBuilder(
            builder: (context, c) {
              return Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: themeData.colorScheme.primaryContainer,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                constraints: BoxConstraints(
                  maxWidth: maxWidth,
                ),
                child: Image.asset(message.img!),
              );
            },
          );
        }

        if (message.msg != null) {
          msgWidget = Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: message.own
                  ? AppColors.appMain
                  : themeData.colorScheme.primaryContainer,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(24),
                topRight: const Radius.circular(24),
                bottomLeft:
                    Radius.circular(message.own || continuously ? 24 : 8),
                bottomRight:
                    Radius.circular(message.own && !continuously ? 8 : 24),
              ),
            ),
            constraints: BoxConstraints(
              maxWidth: maxWidth,
            ),
            child: ExpressionText(
                message.msg!,
                message.own
                    ? const TextStyle(
                        fontSize: Dimens.font_sp14,
                        color: Colors.white,
                        textBaseline: TextBaseline.alphabetic)
                    : themeData.textTheme.titleMedium!),
          );
        }
        Widget contentWidget = Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imgWidget != null) imgWidget,
            if (imgWidget != null && msgWidget != null)
              const SizedBox(
                height: 8,
              ),
            if (msgWidget != null) msgWidget,
          ],
        );
        return Container(
          margin: EdgeInsets.only(
              top: 8, bottom: continuously ? 0 : 8, left: 16, right: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (message.own) const Spacer(),
              if (!message.own)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ClipOval(
                    child: continuously
                        ? const SizedBox(
                            width: 36,
                          )
                        : InkWell(
                            onTap: () {
                              Get.toNamed(MineRoutes.userProfile);
                            },
                            child: Image.asset(
                              'assets/images/picture/touxiang_2.jpeg',
                              height: 36,
                              width: 36,
                            ),
                          ),
                  ),
                ),
              contentWidget,
              if (!message.own) const Spacer(),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final bottomOffset = mq.viewInsets.bottom + mq.padding.bottom;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('李四'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () {
                FocusScope.of(context).unfocus();
                Get.toNamed(MineRoutes.userProfile);
                // controller.loadHistory();
              },
            ),
          ],
        ),
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            _refreshAndMessagesWidgt(context),
            // AnimatedContainer(
            //     padding: EdgeInsets.only(bottom: bottomOffset),
            //     duration: const Duration(milliseconds: 200),
            //     curve: Curves.easeOutQuad,
            //     child: _bottomSendBar(context)),
            // _bottomSendBar(context),
            // _emojiAnimated(context),
            _bottomContain(context),
          ],
        ),
      ),
    );
  }

  Widget _refreshAndMessagesWidgt(context) {
    final themeData = Theme.of(context);
    const Key centerKey = ValueKey('second-sliver-list');

    return Expanded(
      child: EasyRefresh(
        controller: controller.refreshcontroller,
        clipBehavior: Clip.none,
        onRefresh: () {
          controller.loadHistory();
        },
        onLoad: () {
          controller.refreshcontroller.finishLoad();
        },
        footer: ListenerFooter(
          listenable: controller.listenable,
          triggerOffset: 0,
          clamping: false,
        ),
        header: BuilderHeader(
            listenable: controller.listenable,
            triggerOffset: 40,
            clamping: false,
            position: IndicatorPosition.above,
            infiniteOffset: null,
            processedDuration: Duration.zero,
            builder: (context, state) {
              return Stack(
                children: [
                  SizedBox(
                    height: state.offset,
                    width: double.infinity,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 40,
                      child: SpinKitCircle(
                        size: 24,
                        color: themeData.colorScheme.primary,
                      ),
                    ),
                  )
                ],
              );
            }),
        child: GetBuilder<ChatController>(
          builder: (controller) {
            return CustomScrollView(
              controller: controller.scrollController,
              center: centerKey,
              // reverse: true,
              // shrinkWrap: controller.shrinkWrap.value,
              clipBehavior: Clip.none,
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return _buildMessageItem(
                          index, controller.historyMessages, true);
                    },
                    childCount: controller.historyMessages.length,
                  ),
                ),
                SliverList(
                  key: centerKey,
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return _buildMessageItem(
                          index, controller.receiverMessages, false);
                    },
                    childCount: controller.receiverMessages.length,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _bottomSendBar(context) {
    final themeData = Theme.of(context);
    return Container(
      color: themeData.colorScheme.primaryContainer,
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              color: themeData.colorScheme.primary,
              icon: const Icon(Icons.add_circle_outline),
              visualDensity: VisualDensity.compact,
            ),
            IconButton(
              onPressed: () {
                if (MediaQuery.of(context).viewInsets.bottom > 0) {
                  Future.delayed(Duration(seconds: 0), () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                }

                Future.delayed(Duration(seconds: 0), () {
                  controller.showEmoji.value = !controller.showEmoji.value;
                  if (controller.showEmoji.value) {
                    controller.oldShowEmoji.value = true;
                  }
                });

                controller.scrollToBottom(duration: 200);
              },
              color: themeData.colorScheme.primary,
              icon: const Icon(Icons.tag_faces),
              visualDensity: VisualDensity.compact,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Obx(
                  () => TextField(
                    controller: TextEditingController.fromValue(
                        TextEditingValue(
                            text: controller.msg.value, //判断keyword是否为空
                            // 保持光标在最后
                            selection: TextSelection.fromPosition(TextPosition(
                                affinity: TextAffinity.downstream,
                                offset: controller.msg.value.length)))),
                    // controller: controller.inputController,
                    minLines: 1,
                    maxLines: 1,
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
                          if (controller.msg.isNotEmpty) {
                            controller.sendMsg(controller.msg.value);
                            controller.msg.value = "";
                          }
                        },
                        icon: Icon(controller.msg.isNotEmpty
                            ? Icons.send
                            : Icons.keyboard_voice_outlined),
                      ),
                    ),
                    onSubmitted: (value) {
                      controller.sendMsg(controller.msg.value);
                    },
                    onTap: () {
                      controller.showEmoji.value = false;
                      controller.scrollToBottom();
                    },
                    onChanged: (value) {
                      controller.msg.value = value;
                      if (controller.msg.isNotEmpty) {
                        controller.scrollToBottom();
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget _emojiAnimated(context) {
    return AnimatedContainer(
        curve: Curves.easeOutQuad,
        duration: const Duration(milliseconds: 200),
        height: controller.showEmoji.value ? 800.h : 0,
        child: _emojiWidget(context));
  }

  Widget _bottomContain(context) {
    final mq = MediaQuery.of(context);
    final bottomOffset = mq.viewInsets.bottom + mq.padding.bottom;
    final themeData = Theme.of(context);

    return Obx(
      () => AnimatedContainer(
          color: themeData.colorScheme.primaryContainer,
          padding: const EdgeInsets.only(bottom: 0),
          height: controller.showEmoji.value ? 1016.h : bottomOffset + 216.h,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutQuad,
          child: Column(
            children: [_bottomSendBar(context), _emojiAnimated(context)],
          )),
    );
  }

  Widget _emojiWidget(context) {
    final themeData = Theme.of(context);

    return controller.showEmoji.value
        ? Container(
            color: themeData.scaffoldBackgroundColor,
            height: 800.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    child: TabBarView(
                      controller: controller.tabController,
                      children: controller.categoryList.map((tab) {
                        return Container(
                          padding: EdgeInsets.only(
                            left: 36.w,
                            right: 36.w,
                          ),
                          child: MediaQuery.removePadding(
                            removeTop: true,
                            context: context,
                            child: EmojiExpression(
                              (e) {
                                controller.msg.value += "[${e.name}]";
                              },
                              crossAxisCount: 7,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Container(
                    width: 1080.w,
                    height: 120.h,
                    color: themeData.colorScheme.primaryContainer,
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: EmojiTab(
                      tabs: controller.categoryList.map<Tab>((tab) {
                        return Tab(
                          icon: Icon(tab),
                        );
                      }).toList(),
                      controller: controller.tabController,
                    ))
              ],
            ),
          )
        : Container();
  }
}
