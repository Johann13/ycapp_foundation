import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static Future<int> getInt(String key, int defaultValue,
      {bool setDefault = true}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int value = preferences.getInt(key);
    if (value == null && setDefault) {
      await preferences.setInt(key, defaultValue);
      return defaultValue;
    }
    return value;
  }

  static Future<double> getDouble(String key, double defaultValue,
      {bool setDefault = true}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    double value = preferences.getDouble(key);
    if (value == null && setDefault) {
      await preferences.setDouble(key, defaultValue);
      return defaultValue;
    }
    return value;
  }

  static Future<bool> getBool(String key, bool defaultValue,
      {bool setDefault = true}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool value = preferences.getBool(key);
    if (value == null && setDefault) {
      await preferences.setBool(key, value);
      return defaultValue;
    }
    return value;
  }

  static Future<String> getString(String key, String defaultValue,
      {bool setDefault = true}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key) ?? defaultValue;
  }

  static Future<List<String>> getStringList(String key,
      {List<String> defaultValue, bool setDefault = true}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> def = (defaultValue ?? []);
    List<String> value = preferences.getStringList(key);
    if (value == null && setDefault) {
      await preferences.setStringList(key, def);
      return def;
    }
    return value;
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
