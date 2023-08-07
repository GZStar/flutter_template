import '../model/user_model.dart';
import '../network/http_utils.dart';
import 'base.dart';

class TravelAPI {
  // 获取旅行列表
  static loginWithPassword(params) async {
    var target = RequestTargetModel(
        path: '/user/loginWithPwd', method: Method.post, params: params);

    var reslut = await HttpUtils.request(target);
    return UserLoginResponseModel.fromJson(reslut);
  }
}