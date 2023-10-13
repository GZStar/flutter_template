import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_template/app/common/style/app_colors.dart';

import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../controllers/friends_public_controller.dart';

class FriendsPublicView extends GetView<FriendsPublicController> {
  const FriendsPublicView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    final themeData = Theme.of(context);

    return AnnotatedRegion(
      value: themeData.brightness == Brightness.dark
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      child: Scaffold(
          body: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            // 使用false禁止返回键返回
            return true;
          },
          child: GestureDetector(
            onTap: () {
              controller.focusNode.unfocus();
            },
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  _topTitleBar(),
                  _bodyContext(context),
                  // buildBottom(),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  Widget _topTitleBar() {
    return Container(
      height: 55.0,
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  margin: const EdgeInsets.only(left: 15.0),
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Text('取消', style: TextStyle(fontSize: 15)),
                  ))),
          Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  controller.onPublickButtonClick();
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 15.0),
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: AppColors.appMain),
                  child: const Text('发表',
                      style: TextStyle(fontSize: 15, color: Colors.white)),
                ),
              )),
        ],
      ),
    );
  }

  Widget _bodyContext(context) {
    return Expanded(
      child: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
                top: 20.0, left: 20.0, right: 20, bottom: 20),
            constraints: const BoxConstraints(minHeight: 50.0),
            child: TextField(
              focusNode: controller.focusNode,
              controller: controller.inputController,
              maxLines: 5,
              style: const TextStyle(fontSize: 15.0),
              decoration: const InputDecoration.collapsed(
                  hintText: "这一刻的想法...",
                  hintStyle: TextStyle(color: Color(0xff919191), fontSize: 15)),
            ),
          ),
          GetBuilder<FriendsPublicController>(
            builder: (controller) {
              return Container(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 10.0, bottom: 20.0),
                child: GridView.count(
                  shrinkWrap: true,
                  primary: false,
                  crossAxisCount: 3, // 一行的Widget数量
                  crossAxisSpacing: 5, // 水平间距
                  mainAxisSpacing: 5, // 垂直间距
                  childAspectRatio: 1,
                  children: List.generate(controller.mGridCount, (index) {
                    // 这个方法体用于生成GridView中的一个item
                    var content;
                    if (index == controller.entitys.length) {
                      // 添加图片按钮
                      var addCell = Center(
                          child: Image.asset(
                        'assets/images/common/mine_feedback_add_image.png',
                        width: double.infinity,
                        height: double.infinity,
                      ));
                      content = GestureDetector(
                        onTap: () {
                          controller.onAddImageButtonClick(context);
                        },
                        child: addCell,
                      );
                    } else {
                      // 被选中的图片
                      content = Stack(
                        children: <Widget>[
                          Center(
                              child: Image(
                                  image: AssetEntityImageProvider(
                                      controller.entitys[index]),
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover)),
                          Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () {
                                controller.onDeleteImageButtonClick(index);
                              },
                              child: Image.asset(
                                'assets/images/common/mine_feedback_ic_del.png',
                                width: 20.0,
                                height: 20.0,
                              ),
                            ),
                          )
                        ],
                      );
                    }
                    return Container(
                      child: content,
                    );
                  }),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
