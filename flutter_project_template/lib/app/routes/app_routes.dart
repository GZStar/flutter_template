import 'package:flutter_project_template/app/routes/discover_routes.dart';
import 'package:flutter_project_template/app/routes/login_routes.dart';
import 'package:get/get.dart';

import '../modules/main/notfound/notfound_binding.dart';
import '../modules/main/notfound/notfound_view.dart';
import 'main_routes.dart';
import 'mine_routes.dart';

class AppPages {
  static const initial = MainRoutes.splash;

  static final GetPage unknown = GetPage(
    name: MainRoutes.notFound,
    page: () => const NotfoundPage(),
    binding: NotfoundBinding(),
  );

  static final routes = MainPages.routes +
      AccountPages.routes +
      MinePages.routes +
      DiscoverPages.routes;
}
