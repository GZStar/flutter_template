import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/base/base_view.dart';

import '../../common/style/app_colors.dart';
import '../../common/utils/screen_utils.dart';
import '../../common/values/app_values.dart';
import '../../common/widgets/set_cell.dart';
import 'contact_controller.dart';

class ContactView extends BaseView<ContactController> {
  double cellH = 55;
  double leftSpace = 50.0;
  double rowSpace = 8;
  double scrollMaxOffSet = 1000;

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget pageContent(BuildContext context) {
    return body(context);
  }

  @override
  Widget body(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.backgroundColor,
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: getContentCell(),
        ),
      ),
    );
  }

  // cell
  Widget getContentCell() {
    return ListView(
      // physics: const AlwaysScrollableScrollPhysics(),
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      children: <Widget>[
        getHeader(),
        const SizedBox(height: AppValues.smallMargin),
        CommonSetCell(
            cellHeight: cellH,
            lineLeftEdge: leftSpace,
            leftImgPath: 'assets/images/wechat/mine/ic_wallet.png',
            title: '服务',
            hiddenLine: true,
            clickCallBack: () {}),
        SizedBox(height: rowSpace),
        CommonSetCell(
            cellHeight: cellH,
            lineLeftEdge: leftSpace,
            leftImgPath: 'assets/images/wechat/mine/ic_collections.png',
            title: '收藏'),
        CommonSetCell(
            cellHeight: cellH,
            lineLeftEdge: leftSpace,
            leftImgPath: 'assets/images/wechat/mine/ic_album.png',
            title: '相册'),
        CommonSetCell(
            cellHeight: cellH,
            lineLeftEdge: leftSpace,
            leftImgPath: 'assets/images/wechat/mine/ic_cards_wallet.png',
            title: '卡包'),
        CommonSetCell(
          cellHeight: cellH,
          lineLeftEdge: leftSpace,
          leftImgPath: 'assets/images/wechat/mine/ic_emotions.png',
          title: '表情',
          hiddenLine: true,
        ),
        SizedBox(height: rowSpace),
        CommonSetCell(
          cellHeight: cellH,
          lineLeftEdge: leftSpace,
          leftImgPath: 'assets/images/wechat/mine/ic_settings.png',
          title: '设置',
          hiddenLine: true,
          clickCallBack: () {},
        ),
        SizedBox(height: rowSpace),
        CommonSetCell(
          cellHeight: cellH,
          leftImgPath: 'assets/images/other/ic_about.png',
          title: '检查更新',
          text: '有新版本',
          textStyle: const TextStyle(fontSize: 14.0, color: Colors.red),
          hiddenLine: true,
          clickCallBack: () {},
        ),
        const SizedBox(height: 50),
      ],
    );
  }

  // 头部
  Widget getHeader() {
    return Container(
      padding: EdgeInsets.only(
          left: 15, bottom: 40.0, top: ScreenUtils.topSafeHeight + 40),
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          children: <Widget>[
            // getUserPhoto(),
            getUserMoreInfo(),
          ],
        ),
      ),
    );
  }

  Widget getUserPhoto() {
    return InkWell(
      child: Container(
        height: 75,
        width: 75,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            controller.userProfile.avatarUrl ?? "",
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                  'assets/images/wechat/mine/default_nor_avatar.png');
            },
          ),
        ),
      ),
      onTap: () {
        print('点击头像==');
      },
    );
  }

  Widget getUserMoreInfo() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 16.0),
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                print('点击昵称==  ${controller.userProfile.name}');
                // JhNavUtils.pushNamed(context, 'WxPersonInfoPage');
              },
              child: Container(
                width: double.maxFinite,
                child: Text(
                  controller.userProfile.name ?? '',
                  style: const TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                print('跳转个人信息');
              },
              child: Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(controller.userProfile.phoneNum ?? '',
                          style: const TextStyle(
                              fontSize: 17, color: Colors.grey)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: Image.asset(
                        'assets/images/wechat/mine/ic_setting_myQR.png',
                        width: 18.0,
                        height: 18.0,
                        color: AppColors.tipsColor,
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios,
                        size: 18, color: Color(0xFFC8C8C8))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
