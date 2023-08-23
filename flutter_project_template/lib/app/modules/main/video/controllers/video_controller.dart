import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class VideoController extends GetxController {
  //TODO: Implement VideoController
  AssetEntity? asset;
  AssetPickerViewerBuilderDelegate<AssetEntity, AssetPathEntity>? delegate;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();

    asset = Get.arguments['asset'];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
