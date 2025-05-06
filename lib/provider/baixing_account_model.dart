import 'dart:convert';

import 'package:baixinglive/compat/baixing_persistence.dart';
import 'package:baixinglive/entity/baixing_account_entity.dart';
import 'package:baixinglive/provider/baixing_generate_model.dart';
import 'package:flutter/foundation.dart';

import 'baixing_level.dart';

class Baixing_AccountModel extends ChangeNotifier {
  Baixing_AccountEntity? _baixing_current_account;
  static const String mBaixing_Key = "current_account";
  Map<String, Baixing_AccountEntity> _baixing_history_accounts = {};
  static const String mBaixing_History_Key = "history_accounts";

  Future<void> resume() async{
    await Baixing_SharedPreferences.init();
    final str = Baixing_SharedPreferences.baixing_getString(mBaixing_Key);
    if(str.isNotEmpty) {
      final map = json.decode(str);
      _baixing_current_account = Baixing_AccountEntity.fromJson(map);
    }
    final history = Baixing_SharedPreferences.baixing_getString(mBaixing_History_Key);
    if(history.isNotEmpty) {
      Map<String, dynamic> history_map = json.decode(history);
      _baixing_history_accounts = history_map.map((key, value) => MapEntry(key, Baixing_AccountEntity.fromJson(value)));
    }
  }

  Baixing_AccountEntity? get baixing_current_account => _baixing_current_account;

  set baixing_current_account(Baixing_AccountEntity? value) {
    if(_baixing_current_account != null) {
      _baixing_history_accounts[_baixing_current_account!.mBaixing_id] = _baixing_current_account!;
      final map = _baixing_history_accounts.map((key, value) => MapEntry(key, value.toJson()));
      final jsonStr = json.encode(map);
      Baixing_SharedPreferences.baixing_setString(mBaixing_History_Key, jsonStr);
    }
    _baixing_current_account = value;
    if(value == null) {
      Baixing_SharedPreferences.baixing_setString(mBaixing_Key, "");
    } else {
      final map = _baixing_current_account!.toJson();
      final str = json.encode(map);
      Baixing_SharedPreferences.baixing_setString(mBaixing_Key, str);
    }
    notifyListeners();
  }

  String baixing_getNickName() {
    return _baixing_current_account?.mBaixing_nickName ?? "";
  }

  String baixing_getAvatar() {
    String url = _baixing_current_account?.mBaixing_avatarUrl?? "";
    if(url.isEmpty) {
      url = Baixing_GenerateModel
          .baixing_generateRandomAvatarUrls(1)
          .first;
    }
    return url;
  }

  String baixing_getUserId() {
    return _baixing_current_account?.mBaixing_id ?? "";
  }

  List<String> baixing_getUserTag() {
    final List<String> result = [];
    if(_baixing_current_account == null) {
      result.add(Baixing_Level.baixing_fromLevel(0).mBaixing_iconRes);
      return result;
    }
    result.add(Baixing_Level.baixing_fromLevel(_baixing_current_account!.mBaixing_level).mBaixing_iconRes);
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