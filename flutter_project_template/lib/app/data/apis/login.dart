import 'base.dart';

class LoginAPI {
  // 手机密码登录
  static RequestTargetModel loginWithPassword(params) {
    return RequestTargetModel(
        path: '/user/loginWithPwd', method: Method.post, params: params);
  }
}
