import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_project_template/app/routes/discover_routes.dart';
import 'package:get/get.dart';

import '../../../common/utils/qr_code_utils.dart';
import '../../../common/widgets/common_widget.dart';
import '../../../common/widgets/set_cell.dart';
import 'discover_controller.dart';

class DiscoverView extends GetView<DiscoverController> {
  const DiscoverView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('DiscoverView page build');

    return Scaffold(
      appBar: AppBar(
        title: Text('discover'.tr),
        centerTitle: true,
      ),
      body: discoverCell(),
    );
  }
}

double _cellH = 55.0;
double _leftSpace = 50.0;
double _rowSpace = 6;

Widget discoverCell() {
  return ListView(
    children: <Widget>[
      CommonSetCell(
        cellHeight: _cellH,
        leftImgPath: 'assets/images/wechat/discover/ic_social_circle.png',
        title: '朋友圈',
        hiddenLine: true,
//      rightWidget: Image.network('https://gitee.com/iotjh/Picture/raw/master/lufei.png',width: 50,height: 50,),
        rightWidget: Container(
            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: badges.Badge(
                padding: EdgeInsets.all(4),
                position: badges.BadgePosition.topEnd(top: -4, end: -4),
                child: Image.asset('assets/images/other/lufei.png',
                    width: 30, height: 30, fit: BoxFit.fill))),
        clickCallBack: () => _clickCell('朋友圈'),
      ),
      SizedBox(height: _rowSpace),
      CommonSetCell(
        cellHeight: _cellH,
        leftImgPath: 'assets/images/wechat/discover/ic_video_number.png',
        title: '视频号',
        hiddenLine: true,
        clickCallBack: () => _clickCell('视频号'),
      ),
      SizedBox(height: _rowSpace),
      CommonSetCell(
        cellHeight: _cellH,
        lineLeftEdge: _leftSpace,
        leftImgPath: 'assets/images/wechat/discover/ic_quick_scan.png',
        title: '扫一扫',
        clickCallBack: () => _clickCell('扫一扫'),
      ),
      CommonSetCell(
        cellHeight: _cellH,
        leftImgPath: 'assets/images/wechat/discover/ic_shake_phone.png',
        title: '摇一摇',
        hiddenLine: true,
        clickCallBack: () => _clickCell('摇一摇'),
      ),
      SizedBox(height: _rowSpace),
      CommonSetCell(
        cellHeight: _cellH,
        lineLeftEdge: _leftSpace,
        leftImgPath: 'assets/images/wechat/discover/ic_feeds.png',
        title: '看一看',
        clickCallBack: () => _clickCell('看一看'),
      ),
      CommonSetCell(
        cellHeight: _cellH,
        leftImgPath: 'assets/images/wechat/discover/ic_quick_search.png',
        title: '搜一搜',
        hiddenLine: true,
        clickCallBack: () => _clickCell('搜一搜'),
      ),
      SizedBox(height: _rowSpace),
      CommonSetCell(
        cellHeight: _cellH,
        leftImgPath: 'assets/images/wechat/discover/ic_people_nearby.png',
        title: '附近的人',
        hiddenLine: true,
        clickCallBack: () => _clickCell('附近的人'),
      ),
      SizedBox(height: _rowSpace),
      CommonSetCell(
        cellHeight: _cellH,
        lineLeftEdge: _leftSpace,
        leftImgPath: 'assets/images/wechat/discover/ic_shopping.png',
        title: '购物',
        clickCallBack: () => _clickCell('购物'),
      ),
      CommonSetCell(
        cellHeight: _cellH,
        leftImgPath: 'assets/images/wechat/discover/ic_game_entry.png',
        title: '游戏',
        hiddenLine: true,
        clickCallBack: () => _clickCell('游戏'),
      ),
      SizedBox(height: _rowSpace),
      CommonSetCell(
        cellHeight: _cellH,
        leftImgPath: 'assets/images/wechat/discover/ic_mini_program.png',
        title: '小程序',
        hiddenLine: true,
        clickCallBack: () => _clickCell('小程序'),
      ),
      SizedBox(height: 15),
    ],
  );
}

// 点击cell
_clickCell(text) {
  // JhToast.showText(context, msg: '点击 $text');

  if (text == '朋友圈') {
    Get.toNamed(DiscoverRoutes.friendsCircle);
  } else if (text == '扫一扫') {
    scanClick();
  }
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
