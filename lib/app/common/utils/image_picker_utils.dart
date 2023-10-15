import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../langs/translation_service.dart';

class ImagePickerUtils {
  static Future<List<AssetEntity>?> pickImage(context,
      {int maxAssets = 9, RequestType requestType = RequestType.common}) async {
    // 本地多语言设置
    AssetPickerTextDelegate textDelegate;
    var locale = Get.locale;
    LanguageModel language = TranslationService.languages.firstWhere((element) {
      return element.locale == locale;
    });
    if (language.type == LanguageType.chiness) {
      textDelegate = const AssetPickerTextDelegate();
    } else {
      textDelegate = const EnglishAssetPickerTextDelegate();
    }

    AssetPickerConfig pickerConfig =
        AssetPickerConfig(maxAssets: maxAssets, textDelegate: textDelegate);

    final List<AssetEntity>? fileList =
        await AssetPicker.pickAssets(context, pickerConfig: pickerConfig);

    return fileList;
  }
}
