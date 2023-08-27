import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class CacheUtils {
  static Future<Null> requestPermission(FileSystemEntity file) async {
    // PermissionStatus status = await Permission.storage.status;
    await delDir(file);
  }

  static Future<Null> delDir(FileSystemEntity file) async {
    if (file is Directory && file.existsSync()) {
      print(file.path);
      final List<FileSystemEntity> children =
          file.listSync(recursive: true, followLinks: true);
      for (final FileSystemEntity child in children) {
        await delDir(child);
      }
    }
    try {
      if (file.existsSync()) {
        await file.delete(recursive: true);
      }
    } catch (err) {
      print(err);
    }
  }

  //循环获取缓存大小
  static Future getTotalSizeOfFilesInDir(final FileSystemEntity file) async {
    //  File

    if (file is File && file.existsSync()) {
      int length = await file.length();
      return double.parse(length.toString());
    }
    if (file is Directory && file.existsSync()) {
      List children = file.listSync();
      double total = 0;
      if (children.isNotEmpty)
        for (final FileSystemEntity child in children) {
          total += await getTotalSizeOfFilesInDir(child);
        }
      return total;
    }
    return 0;
  }

  //格式化文件大小
  static String renderSize(value) {
    if (value == null) {
      return '0.0';
    }
    List<String> unitArr = []
      ..add('B')
      ..add('K')
      ..add('M')
      ..add('G');
    int index = 0;
    while (value > 1024) {
      index++;
      value = value / 1024;
    }
    String size = value.toStringAsFixed(2);
    return size + unitArr[index];
  }
}
