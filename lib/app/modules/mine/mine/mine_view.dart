import 'package:flutter/material.dart';
import 'package:flutter_project_template/app/common/style/app_colors.dart';
import 'package:flutter_project_template/app/common/values/dimens.dart';
import 'package:flutter_project_template/app/routes/mine_routes.dart';
import 'package:get/get.dart';

import '../../../common/widgets/set_cell.dart';
import '../../../common/widgets/toast.dart';
import '../../../common/widgets/update_dialog.dart';
import '../../../routes/home_routes.dart';
import 'mine_controller.dart';

class MineView extends GetView<MineController> {
  const MineView({Key? key}) : super(key: key);

  final double cellH = 55;
  final double leftSpace = 50.0;
  final double rowSpace = 8;
  final double scrollMaxOffSet = 1000;

  @override
  Widget build(BuildContext context) {
    print('MineView page build');

    return Scaffold(
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Scaffold(
      // 创建一个公共的 Scrollable 和 Viewport
      body: CustomScrollView(
        primary: true,
        // 弹性效果（在滚动到尽头时仍可继续滚动）
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverAppBar(
            collapsedHeight: 100,
            expandedHeight: 100,
            // pinned: true, // 是否固定
            // floating: true, //是否漂浮
            // snap: false, // 当漂浮时，此参数才有效
            // 让 FlexibleSpaceBar 与外部组件同步滚动（在内部滚动结束后）
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(background: _header(context)),
          ),
          getSliverList(),
        ],
      ),
    );
  }

  Widget _header(context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/service/bg_service_fuwufankui.png',
          fit: BoxFit.cover,
          colorBlendMode: BlendMode.color,
          color: Theme.of(context).appBarTheme.backgroundColor,
        ),
        Positioned(left: 15, right: 15, bottom: 10, child: getHeader())
      ],
    );
  }

  Widget getSliverList() {
    return SliverList(
        delegate: SliverChildListDelegate([
      const SizedBox(height: Dimens.smallMargin),
      CommonSetCell(
          cellHeight: cellH,
          lineLeftEdge: leftSpace,
          leftImgPath: 'assets/images/wechat/mine/ic_wallet.png',
          title: '服务',
          hiddenLine: true,
          clickCallBack: () {
            Get.toNamed(HomeRoutes.chat);
          }),
      SizedBox(height: rowSpace),
      CommonSetCell(
        cellHeight: cellH,
        lineLeftEdge: leftSpace,
        leftImgPath: 'assets/images/wechat/mine/ic_collections.png',
        title: '收藏',
        clickCallBack: () {
          showToast('功能开发中...');
        },
      ),
      CommonSetCell(
        cellHeight: cellH,
        lineLeftEdge: leftSpace,
        leftImgPath: 'assets/images/wechat/mine/ic_album.png',
        title: '测试相册',
        clickCallBack: () {
          Get.toNamed(MineRoutes.testImage);
        },
      ),
      CommonSetCell(
        cellHeight: cellH,
        lineLeftEdge: leftSpace,
        leftImgPath: 'assets/images/wechat/mine/ic_cards_wallet.png',
        title: '卡包',
        clickCallBack: () {
          showToast('功能开发中...');
        },
      ),
      CommonSetCell(
        cellHeight: cellH,
        lineLeftEdge: leftSpace,
        leftImgPath: 'assets/images/wechat/mine/ic_emotions.png',
        title: '测试隐藏状态栏',
        hiddenLine: true,
        clickCallBack: () {
          Get.toNamed(MineRoutes.testHideStatusBar);
        },
      ),
      SizedBox(height: rowSpace),
      CommonSetCell(
        cellHeight: cellH,
        lineLeftEdge: leftSpace,
        leftImgPath: 'assets/images/wechat/mine/ic_settings.png',
        title: '设置',
        hiddenLine: true,
        clickCallBack: () {
          Get.toNamed(MineRoutes.settings);
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
    ]));
  }

  void showUpdateDialog() {
    showDialog<void>(
        context: Get.context!,
        barrierDismissible: false,
        builder: (_) => UpdateDialog());
  }

  // 头部
  Widget getHeader() {
    return InkWell(
      onTap: () {
        Get.toNamed(MineRoutes.userProfile);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [getUserPhoto(), getUserMoreInfo()],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Image.asset(
                  'assets/images/wechat/mine/ic_setting_myQR.png',
                  width: 18.0,
                  height: 18.0,
                  color: Colors.white,
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.white)
            ],
          )
        ],
      ),
    );
  }

  Widget getUserPhoto() {
    return InkWell(
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          image: const DecorationImage(
            fit: BoxFit.fitHeight,
            image: AssetImage('assets/images/other/lufei.png'),
          ),
        ),
      ),
      onTap: () => onPhotoClick(),
    );
  }

  void onPhotoClick() {
    Get.bottomSheet(
        Container(
          color:
              Get.isDarkMode ? AppColors.backgroundDark : AppColors.background,
          child: SafeArea(
              child: Container(
            // color: Colors.white,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(left: 10),
          // width: 120,
          child: Text(
            controller.userProfile.name ?? '路飞',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28.0,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 10, top: 5),
          child: Obx(
            () => Text(
                controller.userProfile.phoneNum ?? controller.testString.value,
                style: const TextStyle(fontSize: 17, color: Colors.white)),
          ),
        )
      ],
    );
  }
}
