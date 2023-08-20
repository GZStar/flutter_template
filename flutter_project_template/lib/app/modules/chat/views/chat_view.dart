import 'dart:math' as math;

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_template/app/common/style/app_colors.dart';
import 'package:flutter_project_template/app/routes/mine_routes.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';

import '../../../common/values/dimens.dart';
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
            child: Text(
              message.msg!,
              style: message.own
                  ? const TextStyle(
                      fontSize: Dimens.font_sp14,
                      color: Colors.white,
                      textBaseline: TextBaseline.alphabetic)
                  : themeData.textTheme.titleMedium,
            ),
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
    final themeData = Theme.of(context);
    const Key centerKey = ValueKey('second-sliver-list');

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
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            Expanded(
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
            ),
            Container(
              color: themeData.colorScheme.primaryContainer,
              child: SafeArea(
                  child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      color: themeData.colorScheme.primary,
                      icon: const Icon(Icons.add_circle_outline),
                      visualDensity: VisualDensity.compact,
                    ),
                    IconButton(
                      onPressed: () {},
                      color: themeData.colorScheme.primary,
                      icon: const Icon(Icons.tag_faces),
                      visualDensity: VisualDensity.compact,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextField(
                          controller: controller.inputController,
                          minLines: 1,
                          maxLines: 4,
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
                                if (controller
                                    .inputController.text.isNotEmpty) {
                                  controller.onSend();
                                }
                              },
                              icon: Obx(() => Icon(controller.textNotEmpty.value
                                  ? Icons.send
                                  : Icons.keyboard_voice_outlined)),
                            ),
                          ),
                          onSubmitted: (_) => controller.onSend(),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
