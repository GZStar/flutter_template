import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../../../../common/utils/image_picker_utils.dart';
import '../../../../common/utils/permission_utils.dart';

class TestImageController extends GetxController {
  //TODO: Implement TestImageController

  List<String> images = [];
  List<AssetEntity?> mEntityList = [];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void openImagePickerView(context) async {
    if (await PermissionsUtils.getPhotosPermission()) {
      final List<AssetEntity>? fileList =
          await ImagePickerUtils.pickImage(context);

      if (fileList != null) {
        mEntityList.addAll(fileList);
        update();
      }
    }
  }
}
