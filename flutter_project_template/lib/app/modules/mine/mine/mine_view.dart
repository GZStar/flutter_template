import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_template/app/common/style/app_colors.dart';
import 'package:flutter_project_template/app/common/values/app_values.dart';
import 'package:flutter_project_template/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../../common/base/base_view.dart';
import '../../../common/utils/screen_utils.dart';
import '../../../common/widgets/common_widget.dart';
import '../../../common/widgets/set_cell.dart';
import '../../../common/widgets/update_dialog.dart';
import 'mine_controller.dart';

class MineView extends BaseView<MineController> {
  double cellH = 55;
  double leftSpace = 50.0;
  double rowSpace = 8;
  double scrollMaxOffSet = 1000;

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return CommonWidget.appBar('',
        systemOverlayStyle: SystemUiOverlayStyle.dark);
  }

  @override
  Widget pageContent(BuildContext context) {
    return body(context);
  }

  @override
  Widget body(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: AppColors.backgroundColor,
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: getContentCell(),
          ),
        ),
        Positioned(
          top: 0,
          child: Obx(() => Container(
                color: Colors.white,
                constraints: BoxConstraints(
                  minWidth: ScreenUtils.screenWidth,
                  maxHeight: controller.topH.value,
                ),
              )),
        ),
      ],
    );
  }

  // cell
  Widget getContentCell() {
    return ListView(
      controller: controller.scrollController,
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
          clickCallBack: () {
            Get.toNamed(AppRoutes.settings);
          },
        ),
        SizedBox(height: rowSpace),
        CommonSetCell(
          cellHeight: cellH,
          leftImgPath: 'assets/images/other/ic_about.png',
          title: '检查更新',
          text: '有新版本',
          textStyle: const TextStyle(fontSize: 14.0, color: Colors.red),
          hiddenLine: true,
          clickCallBack: () {
            showUpdateDialog();
          },
        ),
        const SizedBox(height: 50),
      ],
    );
  }

  void showUpdateDialog() {
    showDialog<void>(
        context: Get.context!,
        barrierDismissible: false,
        builder: (_) => UpdateDialog());
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
            getUserPhoto(),
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
          child: (controller.userProfile.avatarUrl ?? "").isNotEmpty
              ? Image.network(
                  controller.userProfile.avatarUrl ?? "",
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                        'assets/images/wechat/mine/default_nor_avatar.png');
                  },
                )
              : Image.asset('assets/images/wechat/mine/default_nor_avatar.png'),
          // child: FadeInImage(
          //   placeholder: const AssetImage(
          //       'assets/images/wechat/mine/default_nor_avatar.png'),
          //   image: NetworkImage(''),
          //   imageErrorBuilder: (ctx, exception, stackTrace) {
          //     return Container(); //THE WIDGET YOU WANT TO SHOW IF URL NOT RETURN IMAGE
          //   },
          // ),
        ),
      ),
      onTap: () {
        onPhotoClick();
      },
    );
  }

  void onPhotoClick() {
    Get.bottomSheet(
        Container(
          color: Colors.white,
          child: SafeArea(
              child: Container(
            color: Colors.white,
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.photo),
                  title: Text("相册"),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text("相机"),
                  onTap: () {},
                )
              ],
            ),
          )),
        ),
        enableDrag: false);
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
