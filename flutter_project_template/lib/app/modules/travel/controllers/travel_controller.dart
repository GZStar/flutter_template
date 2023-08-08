import 'package:flutter/material.dart';
import 'package:flutter_project_template/app/data/apis/travel.dart';
import 'package:get/get.dart';

import '../../../common/utils/loading.dart';
import '../../../common/widgets/toast.dart';
import '../../../data/model/trave_model.dart';
import '../../../data/model/trave_param_model.dart';
import '../../../data/model/travel_tab_model.dart';
import '../../../data/network/error_handle.dart';

class TravelController extends GetxController with GetTickerProviderStateMixin {
  late TabController tabcontroller;

  RxList<TabGroups> tabs = <TabGroups>[].obs;
  TravelParamsModel? travelParamsModel;

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
    try {
      TravelParamsModel paramsModel = await TravelAPI.loadTravelParams();
      travelParamsModel = paramsModel;

      TravelTabModel travelTabModel = await TravelAPI.loadTravelTabData();
      tabs.value = travelTabModel.district.groups;
      tabcontroller = TabController(length: tabs.length, vsync: this);

      print('555555555555555555');
      print(tabs.length);
      //非.obs声明的属性需手动更新
      update();
    } on NetError catch (e) {
      print(e);
    }
  }
}
