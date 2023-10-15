import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:math' as math;

import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../../../common/style/app_colors.dart';
import '../../../common/values/dimens.dart';
import '../../../routes/mine_routes.dart';
import '../controllers/chat_controller.dart';

class ChatMessageView extends GetView<ChatController> {
  const ChatMessageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _refreshAndMessagesWidgt(context);
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
        // onLoad: () {
        //   controller.refreshcontroller.finishLoad();
        // },
        // footer: ListenerFooter(
        //   listenable: controller.listenable,
        //   triggerOffset: 0,
        //   clamping: false,
        // ),
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
              anchor: controller.anchorData,
              center: centerKey,
              clipBehavior: Clip.none,
              slivers: [
                SliverList.builder(
                  itemCount: controller.historyMessages.length,
                  itemBuilder: (context, index) {
                    return _buildMessageItem(
                        index, controller.historyMessages, true);
                  },
                ),
                SliverList.builder(
                  key: centerKey,
                  itemCount: controller.newMessages.length,
                  itemBuilder: (context, index) {
                    return _buildMessageItem(
                        index, controller.newMessages, false);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildMessageItem(
      int index, List<MessageEntity> messages, bool isTopList) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final themeData = Theme.of(context);
        final message = messages[index];
        final maxWidth = math.min(constraints.maxWidth - 124, 400.0);
        double imgMaxWidth =
            200.0; //math.min(constraints.maxWidth - 124, 200.0);
        double imgMaxHeight = 200;

        Widget? imgWidget;
        Widget? msgWidget;
        Widget? mediaWidget;

        bool continuously = false;
        if (isTopList) {
          continuously = index != 0 && messages[index - 1].own == message.own;
        } else {
          continuously = index != (messages.length - 1) &&
              messages[index + 1].own == message.own;
        }
        if (message.img != null || message.asset != null) {
          if (message.mediaType == 3) {
            mediaWidget = Stack(alignment: Alignment.center, children: [
              Image(image: AssetEntityImageProvider(message.asset!)),
              Positioned(
                  child: Icon(
                Icons.play_circle_fill,
                size: 150.sp,
              )),
            ]);
          } else if (message.mediaType == 4) {
            mediaWidget =
                Image(image: AssetEntityImageProvider(message.asset!));
          } else if (message.mediaType == 2) {
            mediaWidget = Image.asset(message.img!);
          } else {
            mediaWidget = Image.asset(message.img!);
          }

          imgWidget = LayoutBuilder(
            builder: (context, c) {
              return Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: themeData.colorScheme.primaryContainer,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                constraints: BoxConstraints(
                  maxWidth: imgMaxWidth,
                  maxHeight: imgMaxHeight,
                ),
                child: InkWell(
                    onTap: () {
                      controller.onMessageTap(message);
                    },
                    child: mediaWidget),
              );
            },
          );
        }

        if (message.msg != null && message.msg != '') {
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
            child: Text(message.msg!,
                style: message.own
                    ? const TextStyle(
                        fontSize: Dimens.font_sp14,
                        color: Colors.white,
                        textBaseline: TextBaseline.alphabetic)
                    : themeData.textTheme.titleMedium!),
          );
        }
        Widget contentWidget = Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              message.own ? CrossAxisAlignment.end : CrossAxisAlignment.start,
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
}
