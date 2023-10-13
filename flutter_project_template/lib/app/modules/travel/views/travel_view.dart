import 'package:flutter/material.dart';
import 'package:flutter_project_template/app/data/model/travel_tab_model.dart';
import 'package:flutter_project_template/app/modules/travel/views/travel_page_view.dart';

import 'package:get/get.dart';

import '../controllers/travel_controller.dart';

class TravelView extends GetView<TravelController> {
  const TravelView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('TravelView  build');

    return Scaffold(
      appBar: AppBar(
        title: Text('travel'.tr),
        centerTitle: true,
      ),
      body: _travelBody(),
    );
  }

  Widget _travelBody() {
    return Column(
      children: [
        _tabBar(),
        _travelPage(),
      ],
    );
  }

  Widget _tabBar() {
    return Container(
      // color: Colors.white,
      padding: const EdgeInsets.only(left: 2),
      child: Obx(() => TabBar(
            controller: controller.tabcontroller,
            isScrollable: true,
            indicatorColor: Color(0xff2FCFBB),
            indicatorPadding: EdgeInsets.all(6),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 2.2,
            labelStyle: const TextStyle(fontSize: 18),
            unselectedLabelStyle: const TextStyle(fontSize: 15),
            tabs: controller.tabs.map<Tab>((TabGroups tab) {
              return Tab(
                text: tab.name,
              );
            }).toList(),
          )),
    );
  }

  Widget _travelPage() {
    return Flexible(
        child: Container(
      padding: const EdgeInsets.fromLTRB(6, 3, 6, 0),
      child: Obx(() => TabBarView(
          controller: controller.tabcontroller,
          children: controller.tabs.map((tab) {
            return TravelTabPage(
              travelUrl: controller.travelParamsModel!.url,
              params: controller.travelParamsModel!.params,
              groupChannelCode: tab.code,
            );
          }).toList())),
    ));
  }
}
