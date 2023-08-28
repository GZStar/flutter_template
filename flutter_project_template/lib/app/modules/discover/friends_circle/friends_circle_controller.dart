import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_project_template/app/routes/discover_routes.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

class FriendsCircleController extends GetxController {
  var dataArr = [].obs;

  @override
  void onInit() {
    super.onInit();

    loadData();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  @override
  void dispose() {
    super.dispose();
  }

  void loadData() async {
    // 获取微信运动排行榜数据
    final jsonStr =
        await rootBundle.loadString('assets/data/wx_friends_circle.json');

    Map dic = json.decode(jsonStr);
    List tempDataArr = dic['data'];
    dataArr.value = tempDataArr;
  }

  void pickFromCamera(context) async {
    final AssetEntity? entity = await CameraPicker.pickFromCamera(context);
    if (entity != null) {
      _getToFriendsPublicView([entity]);
    }
  }

  void pickFromPhoto(context) async {
    final List<AssetEntity>? fileList = await AssetPicker.pickAssets(context,
        pickerConfig: const AssetPickerConfig(
          maxAssets: 9,
        ));

    if (fileList != null) {
      _getToFriendsPublicView(fileList);
    }
  }

  void _getToFriendsPublicView(entitys) async {
    var data = await Get.toNamed(DiscoverRoutes.friendsPublic,
        arguments: {'entitys': entitys});

    print('back data = ${data}');
    if (data != null) {
      dataArr.insert(0, data);
    }
  }
}
