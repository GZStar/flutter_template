import 'package:get/get.dart';

import '../modules/login/login_binding.dart';
import '../modules/login/login_view.dart';

abstract class AccountRoutes {
  /// 登录
  static const login = '/login';

  static const register = '/register';
}

class AccountPages {
  static final List<GetPage> routes = <GetPage>[
    GetPage(
      name: AccountRoutes.login,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
  ];
}
