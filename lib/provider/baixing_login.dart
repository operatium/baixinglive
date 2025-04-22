import 'dart:async';

import 'package:baixinglive/business/net/baixing_net_core_work.dart';
import 'package:flutter/cupertino.dart';

class Baixing_LoginModel extends ChangeNotifier {
  final int remainingSeconds = 60;

  String _baixing_userin_phoneNumber = "";
  String _baixing_userin_code = "";
  
  String _baixing_netin_userToken = "";
  String _baixing_netin_code = "";

  String _baixing_out_code_button_text = "获取验证码";
  var _baixing_code_start_time = DateTime.now().millisecondsSinceEpoch;

  Future<bool> baixing_sendCode({required String phoneNumber}) async {
    _baixing_userin_phoneNumber = phoneNumber;
    _startTime();
    var code = await Baixing_NetCoreWork.sendCode(phoneNumber: phoneNumber);
    if (code.length == 6) {
      return true;
    }else {
      _baixing_code_start_time = 0;
      baixing_out_code_button_text = "获取验证码";
      return false;
    }
  }

  Future<bool> baixing_login({required String phoneNumber, required String code,}) async{
    _baixing_userin_phoneNumber = phoneNumber;
    _baixing_userin_code = code;
    var result = await Baixing_NetCoreWork.login(phoneNumber: phoneNumber, code: code);
    _baixing_netin_userToken = result;
    return result == "user01";
  }

  void _startTime() {
    _baixing_code_start_time = DateTime.now().millisecondsSinceEpoch;
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      var t = DateTime.now().millisecondsSinceEpoch - _baixing_code_start_time;
      if (t > 0 && t < remainingSeconds * 1000) {
        baixing_out_code_button_text = "${remainingSeconds - t ~/ 1000}s";
      } else {
        baixing_out_code_button_text = "获取验证码";
        timer.cancel();
      }
    });
  }

  set baixing_code_start_time(value) {
    _baixing_code_start_time = value;
    notifyListeners();
  }

  String get baixing_out_code_button_text => _baixing_out_code_button_text;

  set baixing_out_code_button_text(String value) {
    _baixing_out_code_button_text = value;
    notifyListeners();
  }

  String get baixing_netin_code => _baixing_netin_code;

  set baixing_netin_code(String value) {
    _baixing_netin_code = value;
    notifyListeners();
  }

  String get baixing_netin_userToken => _baixing_netin_userToken;

  set baixing_netin_userToken(String value) {
    _baixing_netin_userToken = value;
    notifyListeners();
  }

  String get baixing_userin_code => _baixing_userin_code;

  set baixing_userin_code(String value) {
    _baixing_userin_code = value;
    notifyListeners();
  }
}