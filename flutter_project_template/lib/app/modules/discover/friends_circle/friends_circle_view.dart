import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_template/app/common/style/app_colors.dart';
import 'package:get/get.dart';

import '../../../common/base/base_view.dart';
import '../../../common/utils/screen_utils.dart';
import '../../../common/widgets/common_widget.dart';
import '../../../common/widgets/nine_picture.dart';
import 'friends_circle_controller.dart';

class FriendsCircleView extends BaseView<FriendsCircleController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return CommonWidget.appBar('朋友圈'.tr);
  }

  @override
  Widget body(BuildContext context) {
    return Obx(() => _body(context, controller.dataArr));
  }

  Widget _body(context, dataArr) {
    var navBgColor = AppColors.appBarColor;
    navBgColor = navBgColor.withOpacity(controller.appbarOpacity.value);

    return Stack(children: <Widget>[
      Container(
        color: AppColors.backgroundColor,
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView.builder(
              controller: controller.scrollController,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: dataArr.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Container(
                    width: double.infinity,
                    height: controller.imgNormalHeight,
                  );
                }
                return _cell(context, dataArr[index - 1]);
              }),
        ),
      ),
      Positioned(
        top: 0,
        left: 0,
        right: 0,
        height: controller.imgChangeHeight.value,
        child: _header(context),
      ),
      // Positioned(
      //   top: 0,
      //   left: 0,
      //   right: 0,
      //   child: BaseAppBar('朋友圈',
      //       bgColor: _navBgColor,
      //       brightness:
      //           _appbarOpacity == 1.0 ? Brightness.light : Brightness.dark,
      //       rightImgPath: 'assets/wechat/discover/ic_xiangji.png',
      //       rightItemCallBack: () {
      //     _clickNav();
      //   }),
      // ),
    ]);
  }

  // _header
  Widget _header(context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 20),
          // child: Image.network(
          //   'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
          //   fit: BoxFit.cover,
          // ),
          child: Image.asset(
            'assets/images/wechat/discover/friends/wx_bg0.jpeg',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
            right: 20,
            bottom: 0,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: const Text(
                    '小于',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                InkWell(
                  child: Container(
                    height: 75,
                    width: 75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: AssetImage('assets/images/other/lufei.png'),
                      ),
                    ),
                  ),
                  onTap: () => _jumpInfo(),
                ),
              ],
            )),
      ],
    );
  }

  // cell
  Widget _cell(context, item) {
    return InkWell(
        onTap: () => _clickCell(context, item['name']),
        child: Container(
          decoration: const BoxDecoration(
              // border: Border.all(color: KColors.kLineColor, width: 1),
              border: Border(
            bottom: BorderSide(
              width: 0.5,
              color: AppColors.separateLine,
            ), // 下边框
          )),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 头像
              InkWell(
                onTap: () => _jumpInfo(),
                child: Container(
                  margin: EdgeInsets.all(15),
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(item['name'].substring(0, 1),
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                ),
              ),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Container(
                      margin: EdgeInsets.only(top: 13),
                      child: Text(
                        item['name'],
                        style:
                            TextStyle(color: AppColors.blueColor, fontSize: 15),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 5, 15, 5),
                        child: Text(
                          item['content'],
                          style: TextStyle(fontSize: 13),
                        )),
                    _imgs(context, item),
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 5, 15, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item['time'],
                              style: const TextStyle(
                                  color: AppColors.swordsColor, fontSize: 13),
                            ),
                            InkWell(
                              child: Container(
                                width: 34,
                                height: 22,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: Image.asset(
                                  'assets/images/wechat/discover/ic_diandian.png',
                                  color: AppColors.blueColor,
                                ),
                              ),
                              onTap: () => _clickCell(context, '评论'),
                            )
                          ],
                        )),
                  ])),
            ],
          ),
        ));
  }

  // 图片view
  Widget _imgs(context, item) {
    return Container(
        child: NinePicture(
      imgData: item['imgs'],
      lRSpace: (80.0 + 20.0),
      onLongPress: () {
        print('onLongPress:');

        // JhBottomSheet.showText(context, dataArr: ['保存图片']);
      },
    ));
  }

  // 点击cell
  _clickCell(context, text) {
    CommonWidget.toast('点击 $text');
  }

  _clickNav() {
    // JhBottomSheet.showText(context,
    //     title: '请选择操作',
    //     dataArr: ['拍摄', '从手机相册选择'],
    //     clickCallback: (index, text) {});
  }

  _jumpInfo() {
    // 跳转个人信息页 跳转传递model

    // ContactsModel model = ContactsModel();
    // model.id = 123;
    // model.name = '小于';
    // model.namePinyin = '小于';
    // model.phone = '17372826674';
    // model.sex = '0';
    // model.region = '淮北市';
    // model.label = '';
    // model.color = '#c579f2';
    // model.avatarUrl = 'https://gitee.com/iotjh/Picture/raw/master/lufei.png';
    // model.isStar = false;

    // String jsonStr = Uri.encodeComponent(jsonEncode(model));
    // JhNavUtils.pushNamed(context, '${'WxUserInfoPage'}?passValue=$jsonStr');
  }
}
