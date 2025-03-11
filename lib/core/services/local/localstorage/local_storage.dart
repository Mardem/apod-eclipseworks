import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'data/local_storage.dart';

class LocalStorageImpl implements LocalStorage {
  late SharedPreferences preferences;

  Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  Future<String?> getString({required String key}) async {
    return preferences.getString(key);
  }

  @override
  Future<List<String>?> getStringList({required String key}) async {
    return preferences.getStringList(key);
  }

  @override
  Future<void> setString({required String key, required String content}) async {
    await preferences.setString(key, content);
  }

  @override
  Future<void> setStringList({
    required String key,
    required List<String>? content,
  }) async {
    if (content != null) {
      await preferences.setStringList(key, content);
    }
  }

  @override
  Future<void> setJsonList({
    required String key,
    required List<Map<String, dynamic>> content,
  }) async {
    String jsonString = jsonEncode(content);
    await preferences.setString(key, jsonString);
  }

  @override
  Future<List<Map<String, dynamic>>?> getJsonList({required String key}) async {
    String? jsonString = preferences.getString(key);
    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.cast<Map<String, dynamic>>();
    }
    return null;
  }

  @override
  Future<bool> clear() => preferences.clear();
}
