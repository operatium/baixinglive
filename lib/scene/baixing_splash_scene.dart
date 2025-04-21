import 'dart:io';

import 'package:baixinglive/widget/Baixing_privacy_agreement_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

class Baixing_SplashScene extends StatefulWidget {
  const Baixing_SplashScene({super.key});

  @override
  State<Baixing_SplashScene> createState() => _Baixing_SplashSceneState();
}

class _Baixing_SplashSceneState extends State<Baixing_SplashScene> {
  String _TAG = "yyx @_Baixing_SplashSceneState: ";
  CupertinoAlertDialog? _alertDialog = null;

  _Baixing_SplashSceneState() {
    print(_TAG + 'State 构造函数被调用');
  }

  @override
  void initState() {
    super.initState();
    print(_TAG + 'initState 方法被调用');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => createDialog(),
      );
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print(_TAG + 'didChangeDependencies 方法被调用');
  }

  @override
  void didUpdateWidget(covariant Baixing_SplashScene oldWidget) {
    super.didUpdateWidget(oldWidget);
    print(_TAG + 'didUpdateWidget 方法被调用');
  }

  @override
  void deactivate() {
    super.deactivate();
    print(_TAG + 'deactivate 方法被调用');
  }

  @override
  void dispose() {
    print(_TAG + 'dispose 方法被调用');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(_TAG + 'build 方法被调用');
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/baixing_bg_jianbian.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                width: 80.w,
                height: 82.w,
                child: Image.asset("images/baixing_logo.webp"),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: IntrinsicHeight(
                child: Container(
                  margin: EdgeInsets.only(bottom: 20.w),
                  child: Column(
                    children: [
                      Container(
                        width: 77.w,
                        height: 20.w,
                        margin: EdgeInsets.only(bottom: 5.w),
                        child: Image.asset("images/baixing_99zhibo_text.webp"),
                      ),
                      Text(
                        "与喜欢的你不期而遇",
                        style: TextStyle(
                          color: Color(0xFF999999),
                          fontSize: 8.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  CupertinoAlertDialog createDialog() => CupertinoAlertDialog(
    title: const Text('个人信息保护指引'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [BaixingPrivacyAgressmentText()],
    ),
    actions: [
      CupertinoDialogAction(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('取消'),
      ),
      CupertinoDialogAction(
        onPressed: () async {
          Navigator.of(context).pop();
          if (Platform.isAndroid || Platform.isIOS) {
            await Permission.storage.request();
            await Permission.camera.request();
            await Permission.microphone.request();
          }
          GoRouter.of(context).go("/selectLogin");
        },
        isDefaultAction: true,
        child: const Text('确认'),
      ),
    ],
  );
}
