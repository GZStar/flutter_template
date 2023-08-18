import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:badges/badges.dart' as badges;

import '../../common/utils/qr_code_utils.dart';
import '../../common/widgets/common_widget.dart';
import '../../common/widgets/home_pop_menus.dart';
import '../../routes/home_routes.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home'.tr),
        centerTitle: true,
        actions: [_getRightButton()],
      ),
      body: _cellBody(controller.dataArray),
    );
  }

  Widget _getRightButton() {
    return IconButton(
      icon: Image.asset(
        'assets/images/other/ic_nav_add.png',
        width: 20,
        height: 20,
      ),
      onPressed: () {
        showPop(Get.context);
      },
    );
  }

  // body
  Widget _cellBody(dataArr) {
    Widget noRead = CustomSlidableAction(
      padding: const EdgeInsets.all(0),
      backgroundColor: Colors.black87,
      child: const Text(
        '标为未读',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
      onPressed: (context) {
        CommonWidget.toast('点击标为未读');
      },
    );

    Widget noAttention = CustomSlidableAction(
      padding: const EdgeInsets.all(0),
      backgroundColor: Colors.black87,
      child: const Text(
        '不再关注',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
      onPressed: (context) {
        CommonWidget.toast('点击不再关注');
      },
    );

    Widget delete = CustomSlidableAction(
      backgroundColor: Colors.red,
      child: const Text(
        '删除',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
      onPressed: (context) {
        CommonWidget.toast('点击删除');
      },
    );
    return SlidableAutoCloseBehavior(
        child: ListView.separated(
      // 列表项构造器
      itemCount: dataArr.length,
      // 分割器构造器
      separatorBuilder: (context, index) {
        return const Divider(
          height: .5,
          indent: 70,
          endIndent: 0,
          // color: AppColors.separateLine,
        );
      },
      itemBuilder: (context, index) {
        List<Widget> tempArr = [];
        if (dataArr[index]['type'] == '1') {
          tempArr.add(delete);
        }
        if (dataArr[index]['type'] == '2') {
          tempArr.addAll([noRead, delete]);
        }
        if (dataArr[index]['type'] == '3') {
          tempArr.addAll([noAttention, delete]);
        }

        var extentRatio = dataArr[index]['type'] == '0'
            ? 0.00001
            : (dataArr[index]['type'] == '1' ? 0.2 : 0.4);

        return Slidable(
          key: Key(dataArr[index]['type']),
          // 右侧按钮列表
          endActionPane: ActionPane(
//            motion: const ScrollMotion(),
            motion: const DrawerMotion(),
            extentRatio: extentRatio,
            // 拖动删除
            dragDismissible: false,
            dismissible: DismissiblePane(
                closeOnCancel: true,
//                dismissThreshold: 0.8,
                onDismissed: () {}),
            children: tempArr,
          ),
          child: cell(dataArr[index]),
        );
      },
    ));
  }

  // cell
  Widget cell(item) {
    return InkWell(
        onTap: () => clickCell(item),
        child: Container(
            color: Get.theme.colorScheme.primaryContainer,
            height: 70,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                badges.Badge(
                  showBadge: item['isNew'],
                  padding: EdgeInsets.all(5),
                  position: badges.BadgePosition.topEnd(top: 5, end: 5),
                  child: Container(
                      width: 70,
                      height: 70,
                      padding: EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          item['img'],
                          width: 60,
                        ),
                      )),
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
//                Container(color: KColors.kLineColor, height: 0.8),
                    const SizedBox(height: 6),
                    Row(
                      children: <Widget>[
                        Expanded(
                            flex: 70,
                            child: Text(item['title'],
                                style: const TextStyle(fontSize: 18))),
                        Expanded(
                            flex: 30,
                            child: Text(
                              item['time'],
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.grey),
                              textAlign: TextAlign.right,
                            )),
                        const SizedBox(width: 10),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(item['subtitle'],
                        style:
                            const TextStyle(fontSize: 15, color: Colors.grey)),
                  ],
                )),
              ],
            )));
  }

  // 点击cell
  void clickCell(item) {
    // JhToast.showText(context, msg: '点击 $item['title']');
    CommonWidget.toast(item['title']);

    // if (item['title'] == 'Demo 列表') {
    //   CommonWidget.toast(item['title']);
    // } else if (item['title'] == 'QQ邮箱提醒') {
    //   JhNavUtils.pushNamed(context, 'WxQQMessagePage');
    // } else if (item['title'] == '订阅号消息') {
    //   JhNavUtils.pushNamed(context, 'WxSubscriptionNumberPage');
    // } else if (item['title'] == '微信运动') {
    //   JhNavUtils.pushNamed(context, 'WxMotionPage');
    // } else {
    //   JhNavUtils.pushNamed(context, 'DemoListPage');
    // }

    Get.toNamed(HomeRoutes.chat);
  }

  // 右上角pop
  void showPop(context) {
    // 不带分割线，不带背景
    HomePopMenus.show(context, clickCallback: (index, selText) {
      print('选中index: ${index}');
      print('选中text: ${selText}');
      if (selText == '扫一扫') {
        scanClick();
      }
    });
    // // 带分割线带背景
    // HomePopMenus.showLinePop(context, isShowBg: true,
    //     clickCallback: (index, selText) {
    //   print('选中index: ${index}');
    //   print('选中text: ${selText}');
    // });

    // // 带分割线不带背景
    // HomePopMenus.showLinePop(context, clickCallback: (index, selText) {
    //   print('选中index: $index');
    //   print('选中text: $selText');

    //   if (selText == '添加朋友') {}
    // if (selText == '扫一扫') {
    //   _scan(context);
    // }
    // });
  }

  void scanClick() {
    QrCodeUtils.jumpScan(
        isShowGridLine: true,
        isShowScanLine: false,
        callBack: (data) {
          print('扫码结果：$data');
          CommonWidget.toast('扫码结果：$data');
        });
  }
}
