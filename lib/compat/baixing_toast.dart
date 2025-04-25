import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Baixing_Toast {

  static void show(String msg) {
    if(Platform.isIOS || Platform.isAndroid) {
      Fluttertoast.showToast(msg: msg);
    } else {
      print('yyx 弹窗: ${msg}');
    }
  }

  static void showCenter(String msg) {
    if (Platform.isIOS || Platform.isAndroid) {
      Fluttertoast.showToast(msg: msg,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else {
      print('yyx 居中弹窗: ${msg}');
    }
  }

  static void cancel() {
    Fluttertoast.cancel();
  }
}