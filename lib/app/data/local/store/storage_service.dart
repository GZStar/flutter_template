import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/**
 * City city = City(name: "成都市");
    StorageService.to.setObject("loc_city", city);

    City? hisCity = StorageService.to.getObj(
        "loc_city", (v) => City.fromJson(v as Map<String, dynamic>));

    /// save object list example.
    /// 存储实体对象list示例。
    List<City> list = [];
    list.add(City(name: "成都市"));
    list.add(City(name: "北京市"));
    StorageService.to.setObjectList("loc_city_list", list);

    List<City>? dataList = StorageService.to.getObjList(
        "loc_city_list", (v) => City.fromJson(v as Map<String, dynamic>));
 */

/// 本地存储
class StorageService extends GetxService {
  static StorageService get to => Get.find();
  static late SharedPreferences prefs;

  Future<StorageService> init() async {
    prefs = await SharedPreferences.getInstance();
    return this;
  }

  /// set object.
  Future<bool> setObject(String key, Object value) {
    return prefs.setString(key, json.encode(value));
  }

  /// get obj.
  T? getObj<T>(String key, T Function(Map v) f, {T? defValue}) {
    Map? map = getObject(key);
    return map == null ? defValue : f(map);
  }

  /// get object.
  Map? getObject(String key) {
    String? data = prefs.getString(key);
    return (data == null || data.isEmpty) ? null : json.decode(data);
  }

  /// get object list.
  Future<bool> setObjectList(String key, List<Object> list) {
    List<String>? dataList = list.map((value) {
      return json.encode(value);
    }).toList();
    return prefs.setStringList(key, dataList);
  }

  /// get obj list.
  List<T>? getObjList<T>(String key, T Function(Map v) f,
      {List<T>? defValue = const []}) {
    List<Map>? dataList = getObjectList(key);
    List<T>? list = dataList?.map((value) {
      return f(value);
    }).toList();
    return list ?? defValue;
  }

  /// get object list.
  List<Map>? getObjectList(String key) {
    List<String>? dataLis = prefs.getStringList(key);
    return dataLis?.map((value) {
      Map dataMap = json.decode(value);
      return dataMap;
    }).toList();
  }

  /// set string.
  Future<bool> setString(String key, String value) {
    return prefs.setString(key, value);
  }

  /// get string.
  String getString(String key, {String defValue = ''}) {
    return prefs.getString(key) ?? defValue;
  }

  /// get bool.
  bool getBool(String key, {bool defValue = false}) {
    return prefs.getBool(key) ?? defValue;
  }

  /// set bool.
  Future<bool> setBool(String key, bool value) {
    return prefs.setBool(key, value);
  }

  /// get int.
  int getInt(String key, {int defValue = 0}) {
    return prefs.getInt(key) ?? defValue;
  }

  /// set int.
  Future<bool> setInt(String key, int value) {
    return prefs.setInt(key, value);
  }

  /// get double.
  double getDouble(String key, {double defValue = 0.0}) {
    return prefs.getDouble(key) ?? defValue;
  }

  /// set double.
  Future<bool> setDouble(String key, double value) {
    return prefs.setDouble(key, value);
  }

  /// get string list.
  List<String> getStringList(String key, {List<String> defValue = const []}) {
    return prefs.getStringList(key) ?? defValue;
  }

  /// set string list.
  Future<bool> setStringList(String key, List<String> value) {
    return prefs.setStringList(key, value);
  }

  /// get dynamic.
  dynamic getDynamic(String key, {Object? defValue}) {
    return prefs.get(key) ?? defValue;
  }

  /// have key.
  bool haveKey(String key) {
    return prefs.getKeys().contains(key);
  }

  /// contains Key.
  bool containsKey(String key) {
    return prefs.containsKey(key);
  }

  /// get keys.
  Set<String> getKeys() {
    return prefs.getKeys();
  }

  /// remove.
  Future<bool> remove(String key) {
    return prefs.remove(key);
  }

  /// clear.
  Future<bool> clear() {
    return prefs.clear();
  }

  /// Fetches the latest values from the host platform.
  Future<void> reload() {
    return prefs.reload();
  }

  /// get Sp.
  SharedPreferences getSp() {
    return prefs;
  }
}
