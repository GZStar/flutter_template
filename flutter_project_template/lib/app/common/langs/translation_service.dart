// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_project_template/app/common/values/storage_key.dart';
import 'package:get/get.dart';
import '../../data/local/store/storage_service.dart';
import 'en_US.dart';
import 'zh_CN.dart';

class TranslationService extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en_US,
        'zh_CN': zh_CN,
      };

  static List<LanguageModel> languages = [
    LanguageModel(key: 'zh_CN', name: '中文', locale: const Locale('zh', 'CN')),
    LanguageModel(
        key: 'en_US', name: 'English', locale: const Locale('en', 'US')),
  ];
}

class LanguageModel {
  late String key;
  late String name;
  late Locale locale;

  LanguageModel({
    required this.key,
    required this.name,
    required this.locale,
  });
}
