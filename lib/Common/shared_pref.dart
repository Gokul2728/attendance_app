import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  // Save String data ---------
  Future<void> saveStringData(
      {required String key, required String data}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, data);
  }

  // Retrieve String data ------------
  Future<String?> getStringData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  // Save int data ---------
  Future<void> saveIntData({required String key, required int data}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, data);
  }

  // Retrieve int data ------------
  Future<int?> getIntData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  // Save bool data ---------
  Future<void> saveBoolData({required String key, required bool data}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, data);
  }

  // Retrieve bool data ------------
  Future<bool?> getBoolData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  // Remove data ------------
  Future<void> removeData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  Future<void> saveJsonData<T>(String key, List<T> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonList =
        data.map((item) => jsonEncode((item as dynamic).toJson())).toList();
    await prefs.setStringList(key, jsonList);
  }

  //
  Future<List<T>?> getJsonData<T>(
      String key, T Function(Map<String, dynamic>) fromJson) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonList = prefs.getStringList(key);

    if (jsonList != null) {
      return jsonList.map((jsonString) {
        Map<String, dynamic> dataJsonMap = jsonDecode(jsonString);
        return fromJson(dataJsonMap);
      }).toList();
    }
    return null;
  }

  Future<void> saveDynamicListData(String key, List<dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Convert each item to a map with 'type' and 'value'
    List<String> encodedData = data.map((item) {
      return jsonEncode({
        'type': item.runtimeType.toString(),
        'value': item,
      });
    }).toList();

    await prefs.setStringList(key, encodedData);
  }

  // Retrieve dynamic list data
  Future<List<dynamic>?> getDynamicListData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? encodedData = prefs.getStringList(key);

    if (encodedData == null) return null;

    return encodedData.map((item) {
      Map<String, dynamic> decodedItem = jsonDecode(item);
      switch (decodedItem['type']) {
        case 'String':
          return decodedItem['value'] as String;
        case 'int':
          return decodedItem['value'] as int;
        case 'double':
          return decodedItem['value'] as double;
        case 'bool':
          return decodedItem['value'] as bool;
        default:
          return decodedItem['value'];
      }
    }).toList();
  }
}
