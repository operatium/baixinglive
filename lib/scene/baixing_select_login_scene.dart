import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class Baixing_SelectLoginScene extends StatefulWidget {
  const Baixing_SelectLoginScene({super.key});

  @override
  State<StatefulWidget> createState() => _Baixing_SelectLoginSceneState();
}

class _Baixing_SelectLoginSceneState extends State<Baixing_SelectLoginScene> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/baixing_girl_xxxl.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 220.w,
                height: 110.w,
                margin: EdgeInsets.only(top: 56.w),
                child: Image.asset("images/baixing_99zhibo_text.webp"),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: IntrinsicHeight(
                child: Container(
                  margin: EdgeInsets.only(bottom: 200.w),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          GoRouter.of(context).go("/login");
                        },
                        child: Container(
                          width: 280.w,
                          height: 44.w,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFFBB68FA), Color(0xFF7654F2)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(22.w),
                          ),
                          child: Center(
                            child: Text(
                              "手机登陆",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          GoRouter.of(context).go("/login");
                        },
                        child: Text(
                          "更多登录方式 >",
                          style: TextStyle(color: Colors.white, fontSize: 14.sp),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
