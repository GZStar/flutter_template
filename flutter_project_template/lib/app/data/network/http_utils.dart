import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../apis/base.dart';
import '../local/store/user_store.dart';
import 'dio_utils.dart';
import 'env_config.dart';

typedef Success<T> = Function(T data);
typedef Fail = Function(int code, String msg);

class HttpUtils {
  // ignore: constant_identifier_names
  static const CONTENT_TYPE_JSON = "application/json;charset=utf-8";

  /// _request 请求
  static void request(
    RequestTargetModel target, {
    Success? success,
    Fail? fail,
  }) {
    var data;
    var queryParameters;
    Map<String, String> tempHeader = {};

    if (target.method == Method.get) {
      queryParameters = target.params;
    } else if (target.method == Method.post) {
      data = target.params;
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

    DioUtils().request(url,
        data: data,
        queryParameters: queryParameters,
        options: options, onSuccess: (result) {
      if (result['code'] == target.successCode) {
        success?.call(result['data']);
      } else {
        if ([401, 402, 405, 410].contains(result['code'])) {
          EasyLoading.showError(result['msg']);
          UserStore.to.onLogout();
        } else if (result['code'] == 403) {
          // 菜单权限被收回
          UserStore.to.onLogout();
        } else if (result['code'] == 135010037) {
          EasyLoading.showError('login_has_expired');
          UserStore.to.onLogout();
        } else {
          // 其他状态，弹出错误提示信息
          EasyLoading.showError(result['msg']);
        }
        fail?.call(result['code'], result['msg']);
      }
    }, onError: (code, msg) {
      EasyLoading.showError(msg);
      fail?.call(code, msg);
    });
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
