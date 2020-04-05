import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static Future<int> getInt(String key, int defaultValue) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(key) ?? defaultValue;
  }

  static Future<double> getDouble(String key, double defaultValue) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getDouble(key) ?? defaultValue;
  }

  static Future<bool> getBool(String key, bool defaultValue) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(key) ?? defaultValue;
  }

  static Future<String> getString(String key, String defaultValue) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key) ?? defaultValue;
  }

  static Future<List<String>> getStringList(String key,
      {List<String> defaultValue}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getStringList(key) ?? (defaultValue ?? List());
  }

  static Future<Set<String>> getKeys() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getKeys();
  }

  static Future<bool> setInt(String key, int value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setInt(key, value);
  }

  static Future<bool> setDouble(String key, double value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setDouble(key, value);
  }

  static Future<bool> setString(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(key, value);
  }

  static Future<bool> setStringList(String key, List<String> value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setStringList(key, value);
  }

  static Future<bool> setBool(String key, bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setBool(key, value);
  }

  static Future<bool> remove(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.remove(key);
  }
}
