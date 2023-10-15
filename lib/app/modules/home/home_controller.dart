import 'package:flutter_project_template/app/common/utils/loading.dart';
import 'package:flutter_project_template/app/data/local/store/user_store.dart';
import 'package:flutter_project_template/app/routes/login_routes.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  List dataArray = [
    {
      'title': 'Demo 列表',
      'subtitle': '点击跳转demo列表',
      'img': 'assets/images/other/ic_demo1.png',
      'time': '',
      'isNew': false,
      'type': '0',
    },
    {
      'title': '微信运动',
      'subtitle': '[应用消息]',
      'img': 'assets/images/wechat/home/wechat_motion.png',
      'time': '22:23',
      'isNew': true,
      'type': '1',
    },
    {
      'title': '订阅号消息',
      'subtitle': '新闻联播开始啦',
      'img': 'assets/images/wechat/home/ic_subscription_number.png',
      'time': '19:00',
      'isNew': true,
      'type': '1',
    },
    {
      'title': 'QQ邮箱提醒',
      'subtitle': '您有一封新的邮件，请前往查收',
      'img': 'assets/images/wechat/home/Ic_email.png',
      'time': '17:30',
      'isNew': false,
      'type': '3',
    },
    {
      'title': '张三',
      'subtitle': '欢迎欢迎',
      'img': 'assets/images/picture/touxiang_1.jpeg',
      'time': '17:30',
      'isNew': false,
      'type': '2',
    },
    {
      'title': '李四',
      'subtitle': 'hello',
      'img': 'assets/images/picture/touxiang_2.jpeg',
      'time': '17:30',
      'isNew': false,
      'type': '2',
    },
    {
      'title': '王五',
      'subtitle': '[图片]',
      'img': 'assets/images/picture/touxiang_3.jpeg',
      'time': '17:30',
      'isNew': false,
      'type': '2',
    },
    {
      'title': '赵六',
      'subtitle': '[动画表情]',
      'img': 'assets/images/picture/touxiang_4.jpeg',
      'time': '17:30',
      'isNew': false,
      'type': '2',
    },
    {
      'title': '微信团队',
      'subtitle': '安全登录提醒',
      'img': 'assets/images/wechat/home/ic_about.png',
      'time': '2020/8/8',
      'isNew': false,
      'type': '1',
    },
  ];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  logout() async {
    Loading.show();
    await UserStore.to.onLogout();
    Get.offAndToNamed(AccountRoutes.login);
    Loading.dismiss();
  }
}
