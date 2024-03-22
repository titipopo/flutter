import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  static void saveData(SharedPreferences prefs, String key, dynamic value) {
    if (value is int) {
      prefs.setInt(key, value);
    } else if (value is String) {
      prefs.setString(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    } else {
      print("Invalid Type");
    }
  }

  static Future<dynamic> readData(SharedPreferences prefs, String key) {
    dynamic obj;
    try {
      obj = prefs.get(key);
    } catch (e) {
      print('error');
    }
    return obj;
  }

  static Future<bool> deleteData(SharedPreferences prefs, String key) {
    return prefs.remove(key);
  }
}
