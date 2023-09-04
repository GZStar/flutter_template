import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_template/app/common/style/app_colors.dart';
import 'package:flutter_project_template/app/routes/mine_routes.dart';
import 'package:get/get.dart';

import '../../../common/widgets/common_widget.dart';
import '../../../common/widgets/nine_picture.dart';
import 'friends_circle_controller.dart';

class FriendsCircleView extends GetView<FriendsCircleController> {
  const FriendsCircleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _body(context, controller.dataArr));
  }

  Widget _body(context, dataArr) {
    return CustomScrollView(
      // 弹性效果（在滚动到尽头时仍可继续滚动）
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      slivers: [
        SliverAppBar(
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
            background: Container(
              color: Get.isDarkMode
                  ? AppColors.backgroundDark
                  : AppColors.background,
              child: _header(context),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () => {_clickNav(context)},
                icon: const Icon(Icons.camera_alt))
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
                  margin: const EdgeInsets.only(bottom: 10),
                  child: const Text(
                    '路飞',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
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
    return Container(
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(
          width: 0.5,
          color: Get.isDarkMode ? AppColors.lineDark : AppColors.line,
        ), // 下边框
      )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 头像
          InkWell(
            onTap: () => _jumpInfo(),
            child: Container(
              margin: const EdgeInsets.all(15),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(item['name'].substring(0, 1),
                    style: const TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ),
          ),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                InkWell(
                  onTap: () => _jumpInfo(),
                  child: Container(
                    margin: const EdgeInsets.only(top: 13),
                    child: Text(
                      item['name'],
                      style: const TextStyle(
                          color: AppColors.gradientBlue, fontSize: 15),
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.fromLTRB(0, 5, 15, 5),
                    child: Text(
                      item['content'],
                      style: const TextStyle(fontSize: 13),
                    )),
                _imgs(context, item),
                Container(
                    margin: const EdgeInsets.fromLTRB(0, 5, 15, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item['time'],
                          style: const TextStyle(fontSize: 13),
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
                              color: AppColors.gradientBlue,
                            ),
                          ),
                          onTap: () => _clickCell(context, '评论'),
                        )
                      ],
                    )),
              ])),
        ],
      ),
    );
  }

  // 图片view
  Widget _imgs(context, item) {
    return Container(
        child: NinePicture(
      imgData: item['imgs'],
      lRSpace: (80.0 + 20.0),
      isAssetImage: item['isAsset'] ?? false,
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

  _clickNav(context) async {
    await showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return CupertinoActionSheet(
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: Text('拍摄'),
                onPressed: () {
                  Navigator.of(context).pop('camera');
                  controller.pickFromCamera(context);
                },
              ),
              CupertinoActionSheetAction(
                child: Text('从手机相册选择'),
                onPressed: () {
                  Navigator.of(context).pop('photo');
                  controller.pickFromPhoto(context);
                },
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              child: Text('取消'),
              onPressed: () {
                Navigator.of(context).pop('cancel');
                // Get.back();
              },
            ),
          );
        });
  }

  _jumpInfo() {
    // 跳转个人信息页 跳转传递model
    Get.toNamed(MineRoutes.userProfile);
  }
}
