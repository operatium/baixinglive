import 'package:baixinglive/fragment/baixing_live_page_fragment.dart';
import 'package:baixinglive/fragment/baixing_me_fragment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Baixing_HomeScene extends StatefulWidget {
  const Baixing_HomeScene({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Baixing_HomeSceneState();
  }
}

class _Baixing_HomeSceneState extends State<Baixing_HomeScene> {
  var _selectedIndex = 0;

  Widget getPage(int index) {
    switch (index) {
      case 0:
        return const Baixing_LiveFragment();
      case 3:
        return const Baixing_MeFragment();
      default:
        return Text("${index}");
    }
  }

  @override
  Widget build(BuildContext context) {
    _showTeenagersDialog();
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(child: getPage(_selectedIndex)),
              Container(color: Colors.grey, height: 0.5),
              BottomNavigationBarTheme(
                data: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.white,
                ),
                child: BottomNavigationBar(
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.camera_alt_rounded),
                      label: "直播",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.message_rounded),
                      label: "消息",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.follow_the_signs_rounded),
                      label: "关注",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person_rounded),
                      label: "我的",
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  selectedItemColor: Color(0xffb888f6),
                  unselectedItemColor: Colors.grey,
                  onTap: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTeenagersDialog() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var isHide = prefs.getBool("青少年模式") ?? false;
    var showTime = prefs.getInt("青少年模式时间") ?? 0;
    final t = DateTime.now().millisecondsSinceEpoch - showTime;
    if (!isHide || t > 24 * 3600 * 1000) {
      showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Color(0x44ffffff), // 设置遮罩层颜色为透明
        builder: (BuildContext context) => _baixing_getTeenagersDialog(),
      );
      await prefs.setBool("青少年模式", true);
      await prefs.setInt("青少年模式时间", DateTime.now().millisecondsSinceEpoch);
    }
  }

  Widget _baixing_getTeenagersDialog() {
    return Dialog(
      child: ClipRRect(
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
                  onTap: () {
                    Navigator.of(context).pop();
                    // 这里可以添加进入青少年模式的逻辑
                  },
                ),
              ),
              // 我知道了按钮
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
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
      ),
    );
  }
}
