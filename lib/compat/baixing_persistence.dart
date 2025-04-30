import 'package:shared_preferences/shared_preferences.dart';

class Baixing_SharedPreferences {
  static SharedPreferences? _sp;

  static init() async {
    _sp ??= await SharedPreferences.getInstance();
  }

  static String baixing_getString(String key) {
    return _sp!.getString(key)??"";
  }

  static void baixing_setString(String key, String value) async {
    await _sp!.setString(key, value);
  }
}
