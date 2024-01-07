import 'package:flutter/material.dart';
import 'package:flutter_project_template/app/data/model/travel_tab_model.dart';
import 'package:flutter_project_template/app/modules/travel/controllers/travel_page_controller.dart';
import 'package:flutter_project_template/app/modules/travel/views/travel_page_view.dart';

import 'package:get/get.dart';

import '../../../common/style/app_colors.dart';
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
    return Obx(() => TabBar(
          controller: controller.tabcontroller,
          isScrollable: true,
          indicator: UnderlineTabIndicator(
              insets: const EdgeInsets.only(left: 30, right: 30, top: 0),
              borderSide: const BorderSide(color: Colors.blue, width: 0),
              borderRadius: BorderRadius.circular(1)),
          tabAlignment: TabAlignment.start,
          labelPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          overlayColor: MaterialStateProperty.resolveWith((states) {
            return Colors.transparent;
          }),
          tabs: _tabList(),
        ));
  }

  List<Widget> _tabList() {
    List<Widget> list = [];

    for (int i = 0; i < controller.tabs.length; i++) {
      String text = controller.tabs[i].name;
      list.add(Container(
        height: 32,
        margin: EdgeInsets.fromLTRB(i == 0 ? 8 : 0, 5, 0, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: controller.selectIndex.value == i
              ? Get.isDarkMode
                  ? AppColors.appMainDark
                  : AppColors.appMain
              : Get.isDarkMode
                  ? Colors.grey
                  : Colors.white,
        ),
        child: Container(
          margin: const EdgeInsets.only(left: 14, right: 14),
          alignment: Alignment.center,
          child: Text(text,
              style: TextStyle(
                fontSize: 14,
                color: controller.selectIndex.value == i
                    ? Get.isDarkMode
                        ? Colors.grey
                        : Colors.white
                    : hexToColor('#000000').withOpacity(0.6),
              )),
        ),
      ));
    }
    return list;
  }

  Widget _travelPage() {
    return Obx(() => (controller.tabs.isEmpty)
        ? Container()
        : Flexible(
            child: Container(
            padding: const EdgeInsets.fromLTRB(6, 3, 6, 0),
            child: TabBarView(
                controller: controller.tabcontroller,
                children: controller.tabs.map((model) {
                  return TravelTabPageContainer(
                    travelUrl: (controller.travelParamsModel != null)
                        ? controller.travelParamsModel!.url
                        : "",
                    params: (controller.travelParamsModel != null)
                        ? controller.travelParamsModel!.params
                        : {},
                    groupChannelCode: model.code,
                    tag: model.code,
                  );
                }).toList()),
          )));
  }
}
