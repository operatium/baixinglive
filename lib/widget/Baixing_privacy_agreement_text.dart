import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class BaixingPrivacyAgressmentText extends StatelessWidget {
  const BaixingPrivacyAgressmentText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "感谢您使用此APP，欢迎您点击查看",
            style: TextStyle(color: Color(0xff999999), fontSize: 12.sp),
          ),
          WidgetSpan(
            child: GestureDetector(
              onTap: () {
                GoRouter.of(context).push("/web?url=https://www.163.com");
              },
              child: Text(
                '《用户协议》',
                style: TextStyle(color: Colors.blue, fontSize: 12.sp),
              ),
            ),
          ),
          TextSpan(
            text: "和",
            style: TextStyle(color: Color(0xff999999), fontSize: 12.sp),
          ),
          WidgetSpan(
            child: GestureDetector(
              onTap: () {
                GoRouter.of(context).push("/web?url=https://www.233.tv");
              },
              child: Text(
                '《隐私政策》',
                style: TextStyle(color: Colors.blue, fontSize: 12.sp),
              ),
            ),
          ),
          TextSpan(
            text: "，如您同意，请点击\“同意\"并接受我们的服务，感谢您的信任!我们非常重视隐私和个人信息保护。在您使用的过程中，我们可能会对您部分个人信息进行收集、使用和共享。\n1、我们可能会申请系统设备权限收集设备信息、日志信息、用户信息推送和安全风控，并申请存储权限用户下载及缓存相关文件。\n2、我们可能会申请位置权限、用于帮助你在发布的信息中展示位置。\n3、上述权限以及摄像头、麦克风、相册,存储空间、GPS等敏感权限均不会默认或强制开启收集信息。\n4、未经您同意，我们不会出售或出租您的任何信息。\n5、您可以访问、更正、删除个人信息，我们也提供账号注销、投诉方式。",
            style: TextStyle(color: Color(0xff999999), fontSize: 12.sp),
          ),
        ],
      ),
    );
  }
}
