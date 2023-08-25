import 'dart:io';

import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

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
    final List<AssetEntity>? fileList = await AssetPicker.pickAssets(context,
        pickerConfig: const AssetPickerConfig(
          maxAssets: 9,
        ));

    if (fileList != null) {
      mEntityList.addAll(fileList);
      update();
      // for (var entity in fileList) {
      //   File? file = await entity.originFile;
      //   if (file != null) {
      //     String? path = file.path;
      //     print('image path = ${path}');

      //     images.add(path);

      //     update();
      //   }
      // }
    }
  }
}
