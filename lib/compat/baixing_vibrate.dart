import 'dart:io';

import 'package:flutter_vibrate/flutter_vibrate.dart';

class Baixing_Vibrate {

  static void vibrate() {
    if(Platform.isAndroid || Platform.isIOS) {
      _vibrate();
    } else {
      print('yyx 设备震动');
    }
  }

  static Future<void> _vibrate() async {
    bool canVibrate = await Vibrate.canVibrate;
    if (canVibrate) {
      Vibrate.vibrate();
    }
  }
}