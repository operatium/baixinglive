import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Baixing_LoginScene extends StatefulWidget {
  const Baixing_LoginScene({super.key});

  @override
  State<Baixing_LoginScene> createState() => _Baixing_LoginSceneState();
}

class _Baixing_LoginSceneState extends State<Baixing_LoginScene> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: EdgeInsets.only(right: 20.w, top: 50.w),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "联系客服",
                  style: TextStyle(color: Color(0xff999999), fontSize: 14.sp),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 32.w, vertical: 50.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      if(Platform.isAndroid || Platform.isIOS) {
                        Fluttertoast.showToast(
                            msg: "This is Center Short Toast",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Color(0x88000000),
                            textColor: Colors.white,
                            fontSize: 16.sp
                        );
                      }
                    },
                    child: SizedBox(
                      width: 40.w,
                      height: 40.w,
                        child: Image.asset("images/baixing_weixin.webp",)
                    ),
                  ),
                  GestureDetector(
                    onTap: () {

                    },
                    child: SizedBox(
                        width: 40.w,
                        height: 40.w,
                        child: Image.asset("images/baixing_qq.webp",)
                    ),
                  ),
                  GestureDetector(
                    onTap: () {

                    },
                    child: SizedBox(
                        width: 40.w,
                        height: 40.w,
                        child: Image.asset("images/baixing_99.webp",)
                    ),
                  ),
                  GestureDetector(
                    onTap: () {

                    },
                    child: SizedBox(
                        width: 40.w,
                        height: 40.w,
                        child: Image.asset("images/baixing_weibo.webp",)
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
