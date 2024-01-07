// ignore_for_file: prefer_initializing_formals

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/toast.dart';
import '../../../data/apis/travel.dart';
import '../../../data/model/trave_model.dart';
import '../../../data/network/error_handle.dart';

class TravelPageController extends GetxController {
  String travelUrl;
  Map params;
  String groupChannelCode;
  final String? tag;

  List<ResultList> travelItems = [];
  int pageIndex = 1;
  var loading = true.obs;
  ScrollController scrollController = ScrollController();

  TravelPageController({
    required String travelUrl,
    required Map params,
    required String groupChannelCode,
    String? tag,
  })  : travelUrl = travelUrl,
        params = params,
        groupChannelCode = groupChannelCode,
        tag = tag;

  @override
  void onInit() {
    super.onInit();
    print("TravelPageController onInit");
    loadData();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        loadData(loadMore: true);
      }
    });
  }

  // @override
  void onReady() {
    super.onReady();
    print("TravelPageController onReady");
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void loadData({loadMore = false}) async {
    if (loadMore) {
      pageIndex++;
    } else {
      pageIndex = 1;
    }

    print("request code is ${groupChannelCode}");

    try {
      TravelModel travelModel = await TravelAPI.fetchTravelList(
          travelUrl, params, groupChannelCode, pageIndex);

      if (loadMore) {
        var tempList = travelModel.resultList;
        travelItems.addAll(tempList);
      } else {
        var tempList = travelModel.resultList;
        travelItems.clear();
        travelItems.addAll(tempList);
      }

      loading.value = false;
      print("update tag is ${tag}");

      update();
    } on NetError catch (e) {
      loading.value = false;
      showWarnToast(e.msg);
      update();
    } catch (e) {
      print('error = ${e}');
    }
  }

  Future<void> handleRefresh() async {
    loadData();
    return;
  }
}
