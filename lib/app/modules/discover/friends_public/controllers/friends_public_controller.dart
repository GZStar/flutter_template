import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

import '../../../../common/utils/image_picker_utils.dart';
import '../../../../common/utils/permission_utils.dart';
import '../../../../common/widgets/toast.dart';

class FriendsPublicController extends GetxController {
  int mGridCount = 0;
  late final List<AssetEntity> entitys;

  late final TextEditingController inputController;
  FocusNode focusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();

    inputController = TextEditingController();

    entitys = Get.arguments["entitys"];
    _getGridCount();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void _getGridCount() {
    if (entitys.length < 9) {
      mGridCount = entitys.length + 1;
    } else {
      mGridCount = entitys.length;
    }

    update();
  }

  void onDeleteImageButtonClick(index) {
    entitys.removeAt(index);
    _getGridCount();
  }

  void onAddImageButtonClick(context) {
    focusNode.unfocus();

    // 如果已添加了9张图片，则提示不允许添加更多
    num size = entitys.length;
    if (size >= 9) {
      showToast("最多只能添加9张图片！");
      return;
    }

    _dddPhoto(context);
  }

  void _dddPhoto(context) async {
    await showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return CupertinoActionSheet(
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: Text('拍摄'),
                onPressed: () {
                  Navigator.of(context).pop('camera');
                  _pickFromCamera(context);
                },
              ),
              CupertinoActionSheetAction(
                child: Text('从手机相册选择'),
                onPressed: () {
                  Navigator.of(context).pop('photo');
                  _pickFromPhoto(context);
                },
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              child: Text('取消'),
              onPressed: () {
                Navigator.of(context).pop('cancel');
                // Get.back();
              },
            ),
          );
        });
  }

  void _pickFromCamera(context) async {
    if (await PermissionsUtils.getCameraPermission() == false) {
      return;
    }
    final AssetEntity? entity = await CameraPicker.pickFromCamera(context);
    if (entity != null) {
      entitys.add(entity);
      _getGridCount();
    }
  }

  void _pickFromPhoto(context) async {
    if (await PermissionsUtils.getPhotosPermission() == false) {
      return;
    }
    int max = 9 - entitys.length;
    final List<AssetEntity>? fileList = await ImagePickerUtils.pickImage(
        context,
        maxAssets: max,
        requestType: RequestType.image);
    if (fileList != null) {
      entitys.addAll(fileList);
      _getGridCount();
    }
  }

  void onPublickButtonClick() {
    focusNode.unfocus();

    if (inputController.text.isEmpty) {
      showToast('内容不能为空!');
    } else {
      var data = {
        "id": 37,
        "name": "路飞",
        "color": "#f279ad",
        "content": inputController.text,
        "time": "刚刚",
        "imgs": entitys,
        "isAsset": true,
      };

      Get.back(result: data);
    }
  }
}
