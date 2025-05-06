import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

/**
* @author yuyuexing
* @date: 2025-05-07
* @description: 进入青少年模式的场景页面，展示青少年模式的说明和限制
*/
class Baixing_EnterTeenagerModeScene extends StatefulWidget {
  const Baixing_EnterTeenagerModeScene({super.key});

  @override
  State<StatefulWidget> createState() => _Baixing_EnterTeenagerModeSceneState();
}

class _Baixing_EnterTeenagerModeSceneState extends State<Baixing_EnterTeenagerModeScene> {
  final String _TAG = 'yyx Baixing_EnterTeenagerModeScene';
  
  @override
  void initState() {
    super.initState();
    print(_TAG + 'initState 方法被调用');
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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("青少年模式"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 顶部图标
            Padding(
              padding: EdgeInsets.only(top: 30.h),
              child: Container(
                width: 100.w,
                height: 100.w,
                decoration: BoxDecoration(
                  color: Color(0xFFE6E0FF),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    'images/baixing_umbrella.png',
                    width: 60.w,
                    height: 60.w,
                  ),
                ),
              ),
            ),
            
            // 内容区域
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 观看内容限制
                    _baixing_buildRestrictionItem(
                      "观看内容限制",
                      "在青少年模式中，我们精选了一批适合青少年观看的优质内容；",
                      Icons.visibility,
                    ),
                    SizedBox(height: 20.h),
                    
                    // 使用功能限制
                    _baixing_buildRestrictionItem(
                      "使用功能限制",
                      "无法进行充值打赏、购买、弹幕评论、视频直播等操作；",
                      Icons.block,
                    ),
                    SizedBox(height: 20.h),
                    
                    // 使用时间限制
                    _baixing_buildRestrictionItem(
                      "使用时间限制",
                      "开启青少年模式后，每日22时至6时将无法使用；单日累计使用时长超过40分钟，需要输入监护密码才能继续使用。",
                      Icons.timer,
                    ),
                  ],
                ),
              ),
            ),
            
            // 底部按钮
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _baixing_enterTeenagerMode();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff8955F7),
                      minimumSize: Size(double.infinity, 50.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                    ),
                    child: Text(
                      "开启青少年模式",
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "每次开启青少年模式都需要设置密码",
                    style: TextStyle(fontSize: 12.sp, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 构建限制项
  Widget _baixing_buildRestrictionItem(String title, String description, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 10.w),
              width: 10.w,
              height: 10.w,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                shape: BoxShape.circle,
              ),
            ),
            Text(
              title,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.w, top: 5.h),
          child: Text(
            description,
            style: TextStyle(fontSize: 14.sp, color: Colors.black87),
          ),
        ),
      ],
    );
  }

  // 进入青少年模式
  Future<void> _baixing_enterTeenagerMode() async {
    // 跳转到设置密码页面
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Baixing_TeenagerModeScene(),
      ),
    );
    
    // 如果成功设置密码并开启青少年模式，返回上一页
    if (result == true) {
      if (!mounted) return;
      Navigator.of(context).pop(true);
    }
  }
}