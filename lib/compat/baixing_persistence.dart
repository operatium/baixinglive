import 'package:shared_preferences/shared_preferences.dart';

class Baixing_SharedPreferences {
  static SharedPreferences? _sp;

  static init() async {
    _sp ??= await SharedPreferences.getInstance();
  }

  static String baixing_getString(String key) {
    return _sp!.getString(key)??"";
  }

  static Future<void> baixing_setString(String key, String value) async {
    await _sp!.setString(key, value);
  }

  static bool baixing_getBool(String key) {
    return _sp!.getBool(key)??false;
  }

  static Future<void> baixing_setBool(String key, bool value) async {
    await _sp!.setBool(key, value);
  }

  static int baixing_getInt(String key) {
    return _sp!.getInt(key)??0;
  }

  static Future<void> baixing_setInt(String key, int value) async {
    await _sp!.setInt(key, value);
  }

  static double baixing_getDouble(String key) {
    return _sp!.getDouble(key)??0.0;
  }

  static Future<void> baixing_setDouble(String key, double value) async {
    await _sp!.setDouble(key, value);
  }

  static List<String>? baixing_getStringList(String key) {
    return _sp!.getStringList(key);
  }

  static Future<void> baixing_setStringList(String key, List<String> value) async {
    await _sp!.setStringList(key, value);
  }

  static Future<void> baixing_remove(String key) async {
    await _sp!.remove(key);
  }

  static Future<void> baixing_clear() async {
    await _sp!.clear();
  }
}
