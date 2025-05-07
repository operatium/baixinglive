import 'dart:async';

import 'package:baixinglive/compat/baixing_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Baixing_ContinueTeenagerModeDialog extends StatelessWidget {
  FutureOr<bool> Function(String) mBaixing_nextDo;
  final TextEditingController _baixing_controller = TextEditingController();

  Baixing_ContinueTeenagerModeDialog({required this.mBaixing_nextDo});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text("家长监护密码验证"),
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        margin: EdgeInsets.only(top: 35.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("请输入监护密码验证身份，以继续使用",
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 10.h),
            CupertinoTextField(
              placeholder: "请输入监护密码",
              obscureText: true,
              controller: _baixing_controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.start,
              maxLength: 6,
              style: TextStyle(fontSize: 14.sp),
            ),
            SizedBox(height: 15.h),
          ],
        ),
      ),
      actions: [
        CupertinoDialogAction(
          child: Text("取消"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        CupertinoDialogAction(
          child: Text("确定",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          onPressed: () async {
            var b = await mBaixing_nextDo(_baixing_controller.text);
            if(!b) {
              Baixing_Toast.show("密码错误，请重新输入");
            }
          },
        ),
      ],
    );
  }

}