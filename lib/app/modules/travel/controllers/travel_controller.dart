import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_template/app/data/apis/travel.dart';
import 'package:get/get.dart';

import '../../../common/utils/loading.dart';
import '../../../data/model/trave_param_model.dart';
import '../../../data/model/travel_tab_model.dart';
import '../../../data/network/error_handle.dart';

class TravelController extends GetxController with GetTickerProviderStateMixin {
  late TabController tabcontroller;

  RxList<TabGroups> tabs = <TabGroups>[].obs;
  TravelParamsModel? travelParamsModel;
  var selectIndex = 0.obs;

  @override
  void onInit() {
    tabs.value = [];
    tabcontroller = TabController(length: 0, vsync: this);

    loadParamsAndTabData();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    tabcontroller.dispose();
    super.onClose();
  }

  void loadParamsAndTabData() async {
    Loading.show();
    try {
      TravelParamsModel paramsModel = await TravelAPI.loadTravelParams();
      travelParamsModel = paramsModel;
      update();

      Loading.dismiss();
    } on NetError catch (e) {
      final jsonStr =
          await rootBundle.loadString('assets/data/travel_params.json');
      Map<String, dynamic> dic = json.decode(jsonStr);

      TravelParamsModel paramsModel = TravelParamsModel.fromJson(dic);
      travelParamsModel = paramsModel;
      update();
      print(e);
      Loading.dismiss();
    }

    TravelTabModel travelTabModel = await TravelAPI.loadTravelTabData();
    tabs.value = travelTabModel.district.groups;
    tabcontroller = TabController(length: tabs.length, vsync: this);
    tabcontroller.addListener(() {
      print("tab listen");
      selectIndex.value = tabcontroller.index;
      update();
    });

    //非.obs声明的属性需手动更新
    update();
  }
}
