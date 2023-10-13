import '../../common/utils/encrypt_utils.dart';
import '../model/user_model.dart';
import '../network/http_utils.dart';
import 'base.dart';

class LoginAPI {
  // 手机密码登录
  static Future<UserLoginResponseModel> loginWithPassword(
      account, password) async {
    var params = {
      "phoneNum": account,
      "pwd": EncryptUtils.aesEncrypt(password),
      "countryCode": "+86"
    };

    var target = RequestTargetModel(
        path: '/user/loginWithPwd', method: Method.post, params: params);

    var result = await HttpUtils.request(target);
    return UserLoginResponseModel.fromJson(result);
  }
}
