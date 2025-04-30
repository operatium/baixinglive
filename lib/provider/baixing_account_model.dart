import 'dart:convert';

import 'package:baixinglive/compat/baixing_persistence.dart';
import 'package:baixinglive/entity/baixing_account_entity.dart';
import 'package:flutter/foundation.dart';

class Baixing_AccountModel extends ChangeNotifier {
  Baixing_AccountEntity? _baixing_current_account;
  static const String mBaixing_Key = "login";

  Baixing_AccountEntity? get baixing_current_account => _baixing_current_account;

  set baixing_current_account(Baixing_AccountEntity? value) {
    _baixing_current_account = value;
    if(_baixing_current_account == null) {
      Baixing_SharedPreferences.baixing_setString(mBaixing_Key, "");
    } else {
      final map = _baixing_current_account!.toJson();
      final str = json.encode(map);
      Baixing_SharedPreferences.baixing_setString(mBaixing_Key, str);
    }
    notifyListeners();
  }
}