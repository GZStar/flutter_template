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
    print('HomeView page build');

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
    return Material(
      child: InkWell(
          onTap: () => clickCell(item),
          child: Container(
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
                          style: const TextStyle(
                              fontSize: 15, color: Colors.grey)),
                    ],
                  )),
                ],
              ))),
    );
  }

  // 点击cell
  void clickCell(item) {
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
  }

  void scanClick() {
    QrCodeUtils.jumpScan(
        isShowGridLine: true,
        isShowScanLine: false,
        callBack: (data) {
          print('扫码结果：$data');
          if (data != "") {
          CommonWidget.toast('扫码结果：$data');
        }
        });
  }
}
