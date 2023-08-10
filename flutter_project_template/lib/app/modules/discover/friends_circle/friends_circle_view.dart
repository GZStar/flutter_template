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
    // return CommonWidget.appBar('朋友圈'.tr);
    return null;
  }

  @override
  Widget pageContent(BuildContext context) {
    return body(context);
  }

  @override
  Widget body(BuildContext context) {
    // return Obx(() => _body(context, controller.dataArr));
    return _body(context, controller.dataArr);
    // return Text('');
  }

  // @override
  // Widget pageScaffold(BuildContext context) {
  //   return _body(context, controller.dataArr);
  // }

  Widget _body(context, dataArr) {
    return CustomScrollView(
      // 弹性效果（在滚动到尽头时仍可继续滚动）
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          backgroundColor: AppColors.appBarColor,
          title: const Text('朋友圈'),
          expandedHeight: 250,
          pinned: true, // 是否固定
          floating: false, //是否漂浮
          snap: false, // 当漂浮时，此参数才有效
          // 让 FlexibleSpaceBar 与外部组件同步滚动（在内部滚动结束后）
          stretch: true,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            stretchModes: const <StretchMode>[StretchMode.zoomBackground],
            // background: Image.network(
            //   "https://r11.realme.net/CN/thread/1555770224727732224.jpg",
            //   //默认是 fit: BoxFit.contain，在容器宽高比背景图片的宽高都大时
            //   //（比如原始图片比较小），不再放大。可以设置为其它效果，让其放大
            //   fit: BoxFit.fitWidth,
            // )
            // background: Image.asset(
            //   "assets/images/wechat/discover/friends/wx_bg0.jpeg",
            //   fit: BoxFit.fitWidth,
            // )
            background: Container(
              color: Colors.white,
              child: _header(context),
            ),
          ),
          actions: [
            IconButton(onPressed: () => {}, icon: const Icon(Icons.camera_alt))
          ],
        ),
        Obx(() => SliverList.builder(
            itemCount: dataArr.length,
            itemBuilder: (BuildContext context, int index) {
              return _cell(context, dataArr[index]);
            }))
      ],
    );
  }

  // _header
  Widget _header(context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 20),
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
                    '路飞',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(width: 10),
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
