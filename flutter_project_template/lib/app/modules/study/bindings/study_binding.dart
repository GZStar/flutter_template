import 'package:get/get.dart';

import '../controllers/study_controller.dart';

class StudyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudyController>(
      () => StudyController(),
    );
  }
}
