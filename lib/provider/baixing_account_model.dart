import 'package:baixinglive/compat/baixing_persistence.dart';
import 'package:baixinglive/entity/baixing_account_entity.dart';
import 'package:baixinglive/provider/baixing_generate_model.dart';

import 'baixing_level.dart';
import '../api/baixing_api_flutter.dart';

class Baixing_AccountModel extends ChangeNotifier {
  Baixing_AccountEntity? _baixing_current_account;
  static const String mBaixing_Key = "current_account";
  Map<String, Baixing_AccountEntity> _baixing_history_accounts = {};
  static const String mBaixing_History_Key = "history_accounts";

  Future<void> resume() async {
    await Baixing_SharedPreferences.init();
    final str = Baixing_SharedPreferences.baixing_getString(mBaixing_Key);
    if (str.isNotEmpty) {
      final map = json.decode(str);
      _baixing_current_account = Baixing_AccountEntity.fromJson(map);
    }
    final history = Baixing_SharedPreferences.baixing_getString(
      mBaixing_History_Key,
    );
    if (history.isNotEmpty) {
      Map<String, dynamic> history_map = json.decode(history);
      _baixing_history_accounts = history_map.map(
        (key, value) => MapEntry(key, Baixing_AccountEntity.fromJson(value)),
      );
    }
  }

  Baixing_AccountEntity? get baixing_current_account =>
      _baixing_current_account;

  Future<void> baixing_setCurrentAccount(Baixing_AccountEntity? value) async {
    if (_baixing_current_account != null) {
      await baixing_addHistoryAccount(_baixing_current_account!);
    }
    _baixing_current_account = value;
    if (value == null) {
      await Baixing_SharedPreferences.baixing_remove(mBaixing_Key);
    } else {
      await baixing_saveCurrentAccount();
    }
    notifyListeners();
  }

  Future<void> baixing_updateCurrentAccount(
    Baixing_AccountEntity account,
  ) async {
    if (_baixing_current_account != null) {
      _baixing_current_account = account;
      await baixing_saveCurrentAccount();
    }
    notifyListeners();
  }

  Future<void> baixing_saveCurrentAccount() async {
    if (_baixing_current_account != null) {
      final jsonStr = json.encode(_baixing_current_account!.toJson());
      await Baixing_SharedPreferences.baixing_setString(mBaixing_Key, jsonStr);
    }
  }

  Future<void> baixing_addHistoryAccount(Baixing_AccountEntity account) async {
    _baixing_history_accounts[account.mBaixing_id] = account;
    await baixing_saveHisoryAccounts();
    notifyListeners();
  }

  Future<void> baixing_removeHistoryAccount(String id) async {
    _baixing_history_accounts.remove(id);
    await baixing_saveHisoryAccounts();
    notifyListeners();
  }

  Future<void> baixing_clearHistoryAccounts() async {
    _baixing_history_accounts.clear();
    await Baixing_SharedPreferences.baixing_remove(mBaixing_History_Key);
    notifyListeners();
  }

  Future<void> baixing_saveHisoryAccounts() async {
    print("yyx 保存历史账号${_baixing_history_accounts.length}");
    final map = _baixing_history_accounts.map(
      (key, value) => MapEntry(key, value.toJson()),
    );
    final jsonStr = json.encode(map);
    await Baixing_SharedPreferences.baixing_setString(
      mBaixing_History_Key,
      jsonStr,
    );
  }

  List<Baixing_AccountEntity> baixing_getHistoryAccounts() {
    if (_baixing_current_account != null &&
        _baixing_history_accounts.isNotEmpty) {
      _baixing_history_accounts.remove(_baixing_current_account!.mBaixing_id);
    }
    return _baixing_history_accounts.values.toList();
  }

  List<Baixing_AccountEntity> baixing_getAllAccounts() {
    if (_baixing_current_account == null) {
      return baixing_getHistoryAccounts();
    } else {
      return [_baixing_current_account!] + baixing_getHistoryAccounts();
    }
  }

  String baixing_getNickName() {
    return _baixing_current_account?.mBaixing_nickName ?? "";
  }

  String baixing_getGender() {
    return _baixing_current_account?.mBaixing_gender ?? "";
  }

  void baixing_setGender(String value) async {
    _baixing_current_account?.mBaixing_gender = value;
    notifyListeners();
  }

  String baixing_getBirthday() {
    return _baixing_current_account?.mBaixing_birthday ?? "";
  }

  void baixing_setBirthday(String value) async {
    _baixing_current_account?.mBaixing_birthday = value;
    await baixing_saveCurrentAccount();
    notifyListeners();
  }

  String baixing_getCity() {
    return _baixing_current_account?.mBaixing_city ?? "";
  }

  void baixing_setCity(String value) async {
    _baixing_current_account?.mBaixing_city = value;
    await baixing_saveCurrentAccount();
    notifyListeners();
  }

  String baixing_getConstellation() {
    return _baixing_current_account?.mBaixing_constellation ?? "";
  }

  void baixing_setConstellation(String value) async {
    _baixing_current_account?.mBaixing_constellation = value;
    await baixing_saveCurrentAccount();
    notifyListeners();
  }

  String baixing_getAvatar() {
    String url = _baixing_current_account?.mBaixing_avatarUrl ?? "";
    print("yyx- 头像：$url");
    if (url.isEmpty) {
      url = Baixing_GenerateModel.baixing_generateRandomAvatarUrls(1).first;
    }
    return url;
  }

  void baixing_updataAvatar(String url) async {
    print("yyx- set头像：$url");
    if (url.isEmpty) {
      url = Baixing_GenerateModel.baixing_generateRandomAvatarUrls(1).first;
    }
    _baixing_current_account?.mBaixing_avatarUrl = url;
    await baixing_saveCurrentAccount();
    notifyListeners();
  }

  String baixing_getUserId() {
    return _baixing_current_account?.mBaixing_id ?? "";
  }

  List<String> baixing_getUserTag() {
    final List<String> result = [];
    if (_baixing_current_account == null) {
      result.add(Baixing_Level.baixing_fromLevel(0).mBaixing_iconRes);
      return result;
    }
    result.add(
      Baixing_Level.baixing_fromLevel(
        _baixing_current_account!.mBaixing_level,
      ).mBaixing_iconRes,
    );
    return result;
  }

  int baixing_getUserLevel() {
    return _baixing_current_account?.mBaixing_level ?? 0;
  }

  String baixing_getLevelTimeout() {
    return _baixing_current_account?.mBaixing_levelTimeoutHit ?? "";
  }

  String baixing_getLevelUpdateHit() {
    return _baixing_current_account?.mBaixing_levelUpdateHit ?? "";
  }
}
