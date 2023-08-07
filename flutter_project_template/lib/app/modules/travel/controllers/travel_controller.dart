import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/travel_tab_model.dart';

class TravelController extends GetxController {
  //TODO: Implement TravelController
  late TabController tabcontroller;

  int pageIndex = 1;
  var loading = true.obs;
  var loadMore = false.obs;

  late RxList<TabGroups> tabs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void loadData({loadMore = false}) {
    if (loadMore) {
      loadMore.value = true;
      pageIndex++;
    } else {
      pageIndex = 1;
    }

    // TravelDao.fetch(widget.travelUrl ?? _TRAVEL_URL, widget.params,
    //         widget.groupChannelCode, pageIndex, PAGE_SIZE)
    //     .then((TravelItemModel model) {
    //   _loading = false;
    //   setState(() {
    //     List<TravelItem> items = _filterItems(model.resultList);
    //     if (travelItems != null) {
    //       travelItems.addAll(items);
    //       _loadMore = false;
    //     } else {
    //       travelItems = items;
    //     }
    //   });
    // }).catchError((e) {
    //   _loading = false;
    //   print(e);
    // });
  }

  // List<TravelItem> _filterItems(List<TravelItem> resultList) {
  //   if (resultList == null) {
  //     return [];
  //   }
  //   List<TravelItem> filterItems = [];
  //   resultList.forEach((item) {
  //     if (item.article != null) {
  //       //移除article为空的模型
  //       filterItems.add(item);
  //     }
  //   });
  //   return filterItems;
  // }

  // @override
  // bool get wantKeepAlive => true;

  Future<void> handleRefresh() async {
    loadData();
    return;
  }
}
