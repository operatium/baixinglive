import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Baixing_SplashScene extends StatelessWidget {
  const Baixing_SplashScene({super.key});

  @override
  Widget build(BuildContext context) {
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
                        style: TextStyle(color: Color(0xFF999999), fontSize: 8.sp),
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
}
