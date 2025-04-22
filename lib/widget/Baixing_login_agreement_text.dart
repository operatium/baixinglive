import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class BaixingLoginAgressmentText extends StatelessWidget {
  const BaixingLoginAgressmentText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        children: [
          TextSpan(
            text: "已阅读并同意",
            style: TextStyle(color: Color(0xff999999), fontSize: 10.sp),
          ),
          WidgetSpan(
            child: GestureDetector(
              onTap: () {
                GoRouter.of(context).push("/web?url=https://www.163.com");
              },
              child: Text(
                '《用户协议》',
                style: TextStyle(color: Colors.blue, fontSize: 10.sp),
              ),
            ),
          ),
          TextSpan(
            text: "和",
            style: TextStyle(color: Color(0xff999999), fontSize: 10.sp),
          ),
          WidgetSpan(
            child: GestureDetector(
              onTap: () {
                GoRouter.of(context).push("/web?url=https://www.233.tv");
              },
              child: Text(
                '《隐私政策》',
                style: TextStyle(color: Colors.blue, fontSize: 10.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
