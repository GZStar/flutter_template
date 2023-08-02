import '../model/user_model.dart';
import '../network/http_utils.dart';
import 'base.dart';

class LoginAPI {
  // 手机密码登录
  static loginWithPassword(params) async {
    var target = RequestTargetModel(
        path: '/user/loginWithPwd', method: Method.post, params: params);

    var reslut = await HttpUtils.request(target);
    return UserLoginResponseModel.fromJson(reslut);
  }
}
