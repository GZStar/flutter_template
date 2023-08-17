import 'package:flutter/material.dart';
import 'package:flutter_project_template/app/data/model/trave_param_model.dart';
import 'package:flutter_project_template/app/data/network/env_config.dart';

import '../model/trave_model.dart';
import '../model/travel_tab_model.dart';
import '../network/http_utils.dart';
import 'base.dart';

class TravelAPI {
  // 获取旅行列表
  static Future<TravelModel> fetchTravelList(
      String url, Map params, String groupChannelCode, int pageIndex) async {
    Map paramsMap = params['pagePara'];
    paramsMap['pageIndex'] = pageIndex;
    paramsMap['pageSize'] = 10;
    paramsMap['groupChannelCode'] = groupChannelCode;

    var target = RequestTargetModel(
        path: url,
        method: Method.post,
        params: paramsMap,
        pathType: URLPathType.allUrl);

    var result = await HttpUtils.request(target);
    return TravelModel.fromJson(result);
  }

  static Future<TravelParamsModel> loadTravelParams() async {
    var target = RequestTargetModel(
        path: 'http://www.devio.org/io/flutter_app/json/travel_page.json',
        method: Method.get,
        pathType: URLPathType.allUrl);

    var result = await HttpUtils.request(target);
    return TravelParamsModel.fromJson(result);
  }

  static Future<TravelTabModel> loadTravelTabData() async {
    var target = RequestTargetModel(
        path:
            'https://m.ctrip.com/restapi/soa2/15612/json/getTripShootHomePage',
        method: Method.get,
        pathType: URLPathType.allUrl);

    var result = await HttpUtils.request(target);
    return TravelTabModel.fromJson(result);
  }
}
