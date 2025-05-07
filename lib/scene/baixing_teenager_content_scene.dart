import 'dart:math';

import 'package:baixinglive/compat/baixing_persistence.dart';
import 'package:baixinglive/api/baixing_api_dialog.dart';
import 'package:baixinglive/dialog/baixing_message_dialog.dart';
import 'package:baixinglive/entity/baixing_final_entity.dart';
import 'package:baixinglive/entity/baixing_video_entity.dart';
import 'package:baixinglive/item/baixing_teen_mode_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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

class _Baixing_TeenagerContentSceneState
    extends State<Baixing_TeenagerContentScene>
    with SingleTickerProviderStateMixin {
  final int mBaixing_totalAllowedTime = 40 * 60 * 1000; // 40分钟（毫秒）
  // 剩余使用时间（分钟）
  int _mBaixing_remainingMinutes = 40;

  // 已用时间（分钟）
  int _mBaixing_usedMinutes = 0;

  // 分类标签
  final List<String> _mBaixing_tabs = ["全部", "教育", "科普", "自然", "历史", "动画"];
  late TabController _mBaixing_tabController;

  final List<Map<String, dynamic>> _mBaixing_contentList = [
    {
      "title": "探索自然奥秘：动物世界大揭秘",
      "category": "自然",
      "duration": "05:30",
      "tag": "自然",
      "cover": "images/baixing_def_cover.jpg",
    },
    {
      "title": "科学启蒙：奇妙化学实验",
      "category": "科普",
      "duration": "08:15",
      "tag": "科普",
      "cover": "images/baixing_def_cover.jpg",
    },
    {
      "title": "数学思维训练：几何图形的奥秘",
      "category": "教育",
      "duration": "10:22",
      "tag": "教育",
      "cover": "images/baixing_def_cover.jpg",
    },
    {
      "title": "古代文明探索：埃及金字塔之谜",
      "category": "历史",
      "duration": "12:45",
      "tag": "历史",
      "cover": "images/baixing_def_cover.jpg",
    },
    {
      "title": "动画片：小熊历险记 第一集",
      "category": "动画",
      "duration": "15:00",
      "tag": "动画",
      "cover": "images/baixing_def_cover.jpg",
    },
    {
      "title": "自然纪录片：海洋生物的奇妙世界",
      "category": "自然",
      "duration": "18:30",
      "tag": "自然",
      "cover": "images/baixing_def_cover.jpg",
    },
    {
      "title": "自然纪录片：海螺是什么",
      "category": "自然",
      "duration": "28:30",
      "tag": "自然",
      "cover": "images/baixing_def_cover.jpg",
    },
    {
      "title": "自然纪录片：水是什么",
      "category": "自然",
      "duration": "10:30",
      "tag": "自然",
      "cover": "images/baixing_def_cover.jpg",
    },
    {
      "title": "自然纪录片：鲸鱼是什么",
      "category": "自然",
      "duration": "8:30",
      "tag": "自然",
      "cover": "images/baixing_def_cover.jpg",
    },
  ];
  Baixing_MessageDialog? _mBaixing_useTimeDialog;

  @override
  void initState() {
    super.initState();
    _mBaixing_tabController = TabController(
      length: _mBaixing_tabs.length,
      vsync: this,
    );
    _baixing_initTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _baixing_checkUseTimeOut();
    });
  }

  @override
  void dispose() {
    _mBaixing_tabController.dispose();
    super.dispose();
  }

  // 初始化计时器
  Future<void> _baixing_initTimer() async {
    await Baixing_SharedPreferences.init();
    final usedTime = Baixing_SharedPreferences.baixing_getInt("青少年模式已使用时间"); // 已使用时间（毫秒）
    final remainingTime = mBaixing_totalAllowedTime - usedTime;
    setState(() {
      _mBaixing_usedMinutes = (usedTime / (60 * 1000)).floor();
      _mBaixing_remainingMinutes = (remainingTime / (60 * 1000)).ceil();
    });
    // 每分钟更新一次剩余时间
    Future.delayed(Baixing_300ms, () async {
      if (!mounted) return;
      _baixing_checkUseTimeOut();
      await Baixing_SharedPreferences.baixing_setInt("青少年模式已使用时间", usedTime + 60 * 1000);
      setState(() {
        _mBaixing_usedMinutes++;
        _mBaixing_remainingMinutes--;
      });
    });
  }

  bool _baixing_checkUseTimeOut() {
    if (!mounted) return true;
    final usedTime = Baixing_SharedPreferences.baixing_getInt("青少年模式已使用时间");
    final result = usedTime > mBaixing_totalAllowedTime;
    if (result) {
      final route = GoRouter.of(context);
      final currentLocation = route.state.fullPath;
      if(currentLocation == "/video") {
        route.go("/teenagerContent");
        return true;
      }
      _mBaixing_useTimeDialog ??= baixing_showTeenagerModeTimeOutDialog(context, () {
        baixing_continueTeenagerModeDialog(context, (password) {
          final b = password == Baixing_SharedPreferences.baixing_getString("青少年模式密码");
          if (b) {
            Baixing_SharedPreferences.baixing_setInt("青少年模式已使用时间", 0);
            _baixing_initTimer();
            final route = Navigator.of(context);
            while(route.canPop()) {
              route.pop();
            }
            _mBaixing_useTimeDialog = null;
          }
          return b;
        });
      });
    } else {
      _baixing_initTimer();
    }
    return !result;
  }

  @override
  Widget build(BuildContext context) {
    print("yyx build青少年模式内容页面");
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          appBar: _baixing_appBar(context),
          body: Column(
            children: [
              _baixing_tabLayout(context),
              Expanded(child: _baixing_tabPage()),
              // 底部时长提示
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Text(
                    "今日已使用 ${(_mBaixing_usedMinutes > 40) ? 40: _mBaixing_usedMinutes} 分钟，剩余可用时长 ${(_mBaixing_remainingMinutes < 0)? 0: _mBaixing_remainingMinutes} 分钟",
                    style: TextStyle(color: Color(0xffBDBDBD), fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 退出青少年模式
  void _baixing_exitTeenagerMode(BuildContext context) {
    baixing_exitTeenagerModeDialog(context, (password) {
      final b = password == Baixing_SharedPreferences.baixing_getString("青少年模式密码");
      if (b) {
        GoRouter.of(context).go("/home");
      }
      return b;
    });
  }

  AppBar _baixing_appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new, color: Colors.black87),
        onPressed: () => _baixing_exitTeenagerMode(context),
      ),
      title: Text("青少年推荐内容"),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        TextButton(
          onPressed: () => _baixing_exitTeenagerMode(context),
          child: Text("退出模式", style: Theme.of(context).textTheme.titleSmall),
        ),
      ],
    );
  }

  Widget _baixing_tabLayout(BuildContext context) {
    // 分类Tab栏
    return Container(
      width: double.infinity,
      height: 25.h,
      child: TabBar(
        controller: _mBaixing_tabController,
        indicatorColor: Colors.deepOrange,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        labelStyle: Theme.of(context).textTheme.labelLarge,
        unselectedLabelStyle: Theme.of(context).textTheme.labelMedium,
        tabs: _mBaixing_tabs.map((e) => Tab(text: e)).toList(),
        dividerHeight: 0,
      ),
    );
  }

  Widget _baixing_item(Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () {
        if(_baixing_checkUseTimeOut()) {
          Baixing_VideoEntity videoEntity = Baixing_VideoEntity(
              mBaixing_VideoUrl: "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
              mBaixing_VideoName: item["title"]
              );
          GoRouter.of(context).push("/video", extra: videoEntity);
        }
      },
      child: Baixing_TeenModeItem(
        mBaixing_cover:
        "https://picsum.photos/100/100?random=${Random().nextInt(1000)}",
        mBaixing_name: item["title"],
        mBaixing_time: item["duration"],
      ),
    );
  }

  Widget _baixing_tabPage() {
    return TabBarView(
      controller: _mBaixing_tabController,
      children:
          _mBaixing_tabs.map((tab) {
            // 按分类过滤内容
            List<Map<String, dynamic>> filtered = _baixing_filterContent(tab);
            final count = filtered.length;
            return Padding(
              padding: EdgeInsets.all(10.w),
              child: GridView.builder(
                itemCount: count,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.w,
                  crossAxisSpacing: 10.w,
                ),
                itemBuilder: (context, idx) {
                  return _baixing_item(filtered[idx]);
                },
              ),
            );
          }).toList(),
    );
  }

  List<Map<String, dynamic>> _baixing_filterContent(String tab) {
    return tab == "全部"
        ? _mBaixing_contentList
        : _mBaixing_contentList
            .where((item) => item["category"] == tab)
            .toList();
  }
}
