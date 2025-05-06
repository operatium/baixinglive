import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:baixinglive/scene/baixing_teenager_mode_scene.dart';

/**
* @author yuyuexing
* @date: 2025-05-06
* @description: 青少年模式内容页面
*/
class Baixing_TeenagerContentScene extends StatefulWidget {
  const Baixing_TeenagerContentScene({super.key});

  @override
  State<StatefulWidget> createState() => _Baixing_TeenagerContentSceneState();
}

class _Baixing_TeenagerContentSceneState extends State<Baixing_TeenagerContentScene> {
  // 剩余使用时间（分钟）
  int _mBaixing_remainingMinutes = 40;
  // 定时器
  late final Future<void> _mBaixing_timerFuture;

  @override
  void initState() {
    super.initState();
    _mBaixing_timerFuture = _baixing_initTimer();
  }

  // 初始化计时器
  Future<void> _baixing_initTimer() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final startTime = prefs.getInt("teenager_mode_start_time") ?? DateTime.now().millisecondsSinceEpoch;
    final usedTime = prefs.getInt("teenager_mode_used_time") ?? 0; // 已使用时间（毫秒）
    
    // 计算剩余时间
    final totalAllowedTime = 40 * 60 * 1000; // 40分钟（毫秒）
    final remainingTime = totalAllowedTime - usedTime;
    
    setState(() {
      _mBaixing_remainingMinutes = (remainingTime / (60 * 1000)).ceil();
      if (_mBaixing_remainingMinutes < 0) _mBaixing_remainingMinutes = 0;
    });
    
    // 每分钟更新一次剩余时间
    Future.delayed(const Duration(minutes: 1), () async {
      if (!mounted) return;
      
      // 更新已使用时间
      final newUsedTime = usedTime + 60 * 1000;
      await prefs.setInt("teenager_mode_used_time", newUsedTime);
      
      setState(() {
        _mBaixing_remainingMinutes--;
        if (_mBaixing_remainingMinutes < 0) _mBaixing_remainingMinutes = 0;
      });
      
      // 如果时间用完，显示提示
      if (_mBaixing_remainingMinutes <= 0) {
        if (!mounted) return;
        _baixing_showTimeUpDialog();
      } else {
        // 继续计时
        _baixing_initTimer();
      }
    });
  }

  // 显示时间用完对话框
  void _baixing_showTimeUpDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("使用时间已到"),
        content: Text("今日使用时间已达到上限，请输入监护密码继续使用"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _baixing_verifyPassword();
            },
            child: Text("输入密码"),
          ),
        ],
      ),
    );
  }

  // 验证密码
  Future<void> _baixing_verifyPassword() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Baixing_TeenagerModeScene(isVerifying: true),
      ),
    );
    
    if (result == true) {
      // 验证成功，退出青少年模式
      if (!mounted) return;
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // 禁止返回
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // 隐藏返回按钮
          title: Text("青少年模式"),
          centerTitle: true,
          actions: [
            // 退出按钮
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: _baixing_verifyPassword,
            ),
          ],
        ),
        body: SafeArea(
          child: FutureBuilder(
            future: _mBaixing_timerFuture,
            builder: (context, snapshot) {
              return Column(
                children: [
                  // 顶部紫色雨伞图标
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30.h),
                    child: Image.asset(
                      'images/baixing_umbrella.png',
                      width: 80.w,
                      height: 80.w,
                    ),
                  ),
                  // 剩余时间提示
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                    decoration: BoxDecoration(
                      color: Color(0xFFF0E6FF),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.access_time, color: Color(0xff8955F7)),
                        SizedBox(width: 10.w),
                        Text(
                          "今日剩余使用时间：${_mBaixing_remainingMinutes}分钟",
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  // 限制说明
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _baixing_buildRestrictionItem(
                            "观看内容限制",
                            "在青少年模式中，我们精选了一批适合青少年观看的优质内容；",
                            Icons.visibility,
                          ),
                          SizedBox(height: 20.h),
                          _baixing_buildRestrictionItem(
                            "使用功能限制",
                            "无法进行充值打赏、购买、弹幕评论、视频直播等操作；",
                            Icons.block,
                          ),
                          SizedBox(height: 20.h),
                          _baixing_buildRestrictionItem(
                            "使用时间限制",
                            "开启青少年模式后，每日22时至6时将无法使用；单日累计使用时长超过40分钟，需要输入监护密码才能继续使用。",
                            Icons.timer,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
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
            Icon(icon, color: Color(0xff8955F7), size: 24.sp),
            SizedBox(width: 10.w),
            Text(
              title,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 34.w, top: 8.h),
          child: Text(
            description,
            style: TextStyle(fontSize: 14.sp, color: Colors.black87),
          ),
        ),
      ],
    );
  }
}