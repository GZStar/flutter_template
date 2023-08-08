import 'package:get/get.dart';

import '../../../common/widgets/toast.dart';
import '../../../data/apis/travel.dart';
import '../../../data/model/trave_model.dart';
import '../../../data/network/error_handle.dart';

class TravelPageController extends GetxController {
  String? travelUrl;
  Map? params;
  String? groupChannelCode;

  RxList<ResultList> travelItems = <ResultList>[].obs;
  int pageIndex = 1;
  var loading = true.obs;

  @override
  void onInit() {
    print('111111111111111111');
    print(travelUrl);
    super.onInit();
    print('33333333333333333');
    print(travelUrl);
  }

  @override
  void onReady() {
    loadData(travelUrl, groupChannelCode, params);
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void loadData(url, code, params, {loadMore = false}) async {
    if (loadMore) {
      loadMore.value = true;
      pageIndex++;
    } else {
      pageIndex = 1;
    }

    try {
      TravelModel travelModel =
          await TravelAPI.fetchTravelList(url, params, code, pageIndex);

      var tempList = travelModel.resultList;
      // if (travelItems.isEmpty) {
      //   travelItems.value = tempList;
      // } else {
      //   travelItems.value += tempList;
      // }
      travelItems.addAll(tempList);
      //非.obs声明的属性需手动更新
      update();
      loading.value = false;
    } on NetError catch (e) {
      loading.value = false;
      showWarnToast(e.msg);
    }
  }

  void handleRefresh(url, code, params) async {
    loadData(url, code, params);
  }
}
