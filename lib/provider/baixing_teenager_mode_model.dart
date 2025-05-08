import '../api/baixing_api.dart';
import '../api/baixing_api_flutter.dart';

class Baixing_TeenagerModeModel extends ChangeNotifier{
  final String KEY_teenager_mode_password = "k00"; //"青少年模式密码";
  final String KEY_teenager_mode_enable = "k01"; //"启用青少年模式";
  final String KEY_teenager_mode_use_time = "k02"; //"青少年模式已使用时间";
  final String KEY_teenager_mode_enter_dialog_last_time = "k03"; //"青少年模式提示对话框";
  final int mBaixing_totalAllowedTime = 40 * 60 * 1000; // 40分钟（毫秒）
  final int mBaxing_enterDialogInterval = 24 * 60 * 60 * 1000; // 24小时（毫秒）

  String _baixing_password = "";
  bool _baixing_enable = false;
  int _baixing_use_time = 0;
  int _baixing_enter_dialog_last_time = 0;

  Future<void> resume() async {
    await Baixing_SharedPreferences.init();
    _baixing_password = Baixing_SharedPreferences.baixing_getString(
      KEY_teenager_mode_password,
    );
    _baixing_enable = Baixing_SharedPreferences.baixing_getBool(
      KEY_teenager_mode_enable,
    );
    _baixing_use_time = Baixing_SharedPreferences.baixing_getInt(
      KEY_teenager_mode_use_time,
    );
    _baixing_enter_dialog_last_time =
        Baixing_SharedPreferences.baixing_getInt(
      KEY_teenager_mode_enter_dialog_last_time,
    );
    print("yyx 恢复baixing_use_time: ${_baixing_use_time / (60 * 1000)}");
  }

  String get baixing_password => _baixing_password;

  bool get baixing_enable => _baixing_enable;

  int get baixing_use_time =>
      (_baixing_use_time > mBaixing_totalAllowedTime)
          ? mBaixing_totalAllowedTime
          : _baixing_use_time;

  int baixing_remainingTime() {
    final _baixing_remainingTime = mBaixing_totalAllowedTime - _baixing_use_time;
    return (_baixing_remainingTime < 0) ? 0 : _baixing_remainingTime;
  }

  int get baixing_enterDialogLastTime => _baixing_enter_dialog_last_time;

  bool baixing_shouldShowEnterDialog() {
    return get_nowTime() - _baixing_enter_dialog_last_time >
        mBaxing_enterDialogInterval;
  }

  Future<void> baixing_setPassword(String value) async {
    _baixing_password = value;
    await Baixing_SharedPreferences.baixing_setString(
      KEY_teenager_mode_password,
      value,
    );
  }

  Future<void> baixing_setEnable(bool value) async {
    _baixing_enable = value;
    await Baixing_SharedPreferences.baixing_setBool(
      KEY_teenager_mode_enable,
      value,
    );
    notifyListeners();
  }

  Future<void> baixing_setUseTime(int value) async {
    _baixing_use_time = value;
    await Baixing_SharedPreferences.baixing_setInt(
      KEY_teenager_mode_use_time,
      value,
    );
    print("yyx baixing_use_time: ${_baixing_use_time / (60 * 1000)}");
    notifyListeners();
  }

  Future<void> baixing_setEnterDialogLastTime(int value) async {
    _baixing_enter_dialog_last_time = value;
    await Baixing_SharedPreferences.baixing_setInt(
      KEY_teenager_mode_enter_dialog_last_time,
      value,
    );
  }

  void baixing_add1minuteToUsedTime() {
    _baixing_use_time += 60 * 1000;
    baixing_setUseTime(_baixing_use_time);
    print("yyx baixing_use_time: ${_baixing_use_time / (60 * 1000)}");
  }

  bool baixing_isUseTimeOver() {
    return _baixing_use_time >= mBaixing_totalAllowedTime;
  }
}
