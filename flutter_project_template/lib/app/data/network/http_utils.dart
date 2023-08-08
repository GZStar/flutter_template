import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_project_template/app/data/network/error_handle.dart';

import '../apis/base.dart';
import '../local/store/user_store.dart';
import 'dio_utils.dart';
import 'env_config.dart';

class HttpUtils {
  // ignore: constant_identifier_names
  static const CONTENT_TYPE_JSON = "application/json;charset=utf-8";

  /// _request 请求
  static Future request(
    RequestTargetModel target, {
    ProgressCallback? sendProgress,
  }) async {
    var data;
    var queryParameters;
    Map<String, String> tempHeader = {};

    if (target.method == Method.get) {
      queryParameters = target.params;
    } else if (target.method == Method.post) {
      if (target.file != null) {
        data = target.file;
      } else {
        data = target.params;
      }
      tempHeader = {"Accept": CONTENT_TYPE_JSON};
    } else {
      data = target.params;
    }

    // 组装URL
    var urlobj = EnvConfig.getPathTypeUrlDic(target.domainNameType);
    var headerURL = urlobj[target.pathType]!;
    var url = headerURL + target.path;

    // 组装header
    var header = requestHeader;
    header.forEach((key, value) {
      tempHeader.addAll({key: value});
    });

    // 设置options
    var options = Options();
    options.headers = tempHeader;
    options.method = MethodValues[target.method];

    var response = await DioUtils().request(url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        sendProgress: sendProgress);

    var result = response.data;
    if (result['code'] == target.successCode) {
      return result['data'];
    } else {
      if (target.pathType == URLPathType.allUrl) {
        return result;
      } else {
        if (result['code'] == 4038) {
          // 菜单权限被收回
          UserStore.to.onLogout();
        } else if (result['code'] == 135010037) {
          EasyLoading.showError('login_has_expired');
          UserStore.to.onLogout();
        } else {
          // 其他状态，弹出错误提示信息
          // EasyLoading.showError(result['msg']);
        }
        throw NetError(result['code'], result['msg']);
      }
    }
  }
}

final requestHeader = {
  'token': UserStore.to.token,
  'Accept-Language': '',
  'App-Version': '',
  'App-Platform': '',
  'Device-Name': '',
  'Device-ID': '',
  'Content-type': 'application/json',
  'Device-Version': '',
};
