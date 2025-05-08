import 'package:baixinglive/api/baixing_api_flutter.dart';
import 'package:baixinglive/api/baixing_api_thirdapi.dart';
import 'package:baixinglive/api/baixing_api_provider.dart';
import 'package:baixinglive/api/baixing_api_time.dart';

class Baixing_TeenagerModeHitDialog extends StatelessWidget{
  const Baixing_TeenagerModeHitDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.w),
      child: Container(
        width: 100.w,
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10.w),
            // 紫色雨伞图标
            Image.asset(
              'images/baixing_umbrella.png',
              width: 50.w,
              height: 50.w,
            ),
            SizedBox(height: 6.w),
            // 标题
            Text(
              "青少年模式",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.w),
              child: Text(
                "为了呵护未成年人健康成长，公众直播特别推出青少年模式，该模式下部分功能无法正常使用。请监护人主动选择，并设置监护密码。",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 14.sp, color: Colors.black87),
              ),
            ),
            // 进入青少年模式链接
            Padding(
              padding: EdgeInsets.only(top: 20.w, bottom: 20.w),
              child: GestureDetector(
                child: Text(
                  "进入青少年模式 >",
                  style: TextStyle(fontSize: 14.sp, color: Color(0xff8955F7)),
                ),
                onTap: () async {
                  Navigator.of(context).pop();
                  // 跳转到青少年模式设置页面
                  GoRouter.of(context).push('/teenager');
                },
              ),
            ),
            // 我知道了按钮
            GestureDetector(
              onTap: () async {
                Navigator.of(context).pop();
                Baixing_TeenagerModeModel model = context.read();
                await model.baixing_setEnterDialogLastTime(get_nowTime());
              },
              child: Container(
                color: Color(0xff8955F7),
                width: double.infinity,
                height: 35.h,
                alignment: Alignment.center,
                child: Text(
                  "我知道了",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
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

