import 'package:flutter/material.dart';
import 'package:flutter_project_template/app/data/model/travel_tab_model.dart';
import 'package:flutter_project_template/app/modules/travel/views/travel_page_view.dart';
import 'package:flutter_project_template/app/modules/travel/views/travel_tab_view.dart';

import 'package:get/get.dart';

import '../../../common/base/base_view.dart';
import '../../../common/style/app_colors.dart';
import '../../../common/widgets/common_widget.dart';
import '../controllers/travel_controller.dart';
import '../controllers/travel_page_controller.dart';

class TravelView extends BaseView<TravelController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return CommonWidget.appBar('travel'.tr, isBackButtonEnabled: false);
  }

  @override
  Widget body(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: _travelBody(),
      ),
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
      color: Colors.white,
      padding: EdgeInsets.only(left: 2),
      child: Obx(() => TabBar(
            controller: controller.tabcontroller,
            isScrollable: true,
            labelColor: Colors.black,
            // labelPadding: EdgeInsets.fromLTRB(8, 6, 8, 0),
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
          // children: controller.tabs.map((TabGroups tab) {
          //   return TravelPageView(
          //     travelUrl: controller.travelParamsModel?.url,
          //     params: controller.travelParamsModel?.params,
          //     groupChannelCode: tab.code,
          //   );
          // }).toList())),
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
