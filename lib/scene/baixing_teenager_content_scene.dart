
import '../api/baixing_api.dart';
import '../api/baixing_api_flutter.dart';
import '../api/baixing_api_thirdapi.dart';
import '../dialog/baixing_message_dialog.dart';

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
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {

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
  Timer? _mBaixing_timer;
  bool baixing_isLock = false;

  @override
  void initState() {
    super.initState();
    _mBaixing_tabController = TabController(
      length: _mBaixing_tabs.length,
      vsync: this,
    );
    _baixing_timer(isStart: true);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _baixing_timer();
    _mBaixing_tabController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        _baixing_timer(isStart: true);
        print('应用回到前台');
        break;
      case AppLifecycleState.inactive:
        _baixing_timer();
        print('应用处于非活动状态');
        break;
      case AppLifecycleState.paused:
        _baixing_timer();
        print('应用进入后台');
        break;
      case AppLifecycleState.detached:
        _baixing_timer();
        print('应用进程已分离');
        break;
      default:
        break;
    }
  }

  void _baixing_timer({bool isStart = false}) {
    if(isStart) {
      _mBaixing_timer ??= Timer.periodic(Baixing_1mi, (timer) {
        print("yyx 定时器开始");
        if (_mBaixing_timer != null) {
          Baixing_TeenagerModeModel model = context.read();
          model.baixing_add1minuteToUsedTime();
          if(mounted && model.baixing_remainingTime() <= 0) {
            _baixing_handleUseTimeOut(context);
          }
        }
      });
      delay300(() {
        Baixing_TeenagerModeModel model = context.read();
        if(mounted && model.baixing_remainingTime() <= 0) {
          _baixing_handleUseTimeOut(context);
        }
      });
    } else {
      _mBaixing_timer?.cancel();
      _mBaixing_timer = null;
    }
  }

  void _baixing_handleUseTimeOut(BuildContext context) {
    final route = GoRouter.of(context);
    final currentLocation = route.state.fullPath;
    if (currentLocation == "/video") {
      route.go("/teenagerContent");
      return;
    }
    _mBaixing_useTimeDialog ??=
        baixing_showTeenagerModeTimeOutDialog(context, () {
          baixing_continueTeenagerModeDialog(context, (password) {
            Baixing_TeenagerModeModel model = context.read();
            final b = password == model.baixing_password;
            if (b) {
              model.baixing_setUseTime(0);
              final route = Navigator.of(context);
              while (route.canPop()) {
                route.pop();
              }
              _mBaixing_useTimeDialog = null;
            }
            return b;
          });
        });
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
                  child: _baixing_showUseTime(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _baixing_showUseTime(BuildContext context) {
    Baixing_TeenagerModeModel model = context.watch();
    return Text(
      "今日已使用 ${model.baixing_use_time / 60000} 分钟，剩余可用时长 ${model.baixing_remainingTime() / 60000} 分钟",
      style: TextStyle(color: Color(0xffBDBDBD), fontSize: 14),
    );
  }

  // 退出青少年模式
  void _baixing_exitTeenagerMode(BuildContext context) {
    Baixing_TeenagerModeModel model = context.read();
    baixing_exitTeenagerModeDialog(context, (password) {
      final b = password == model.baixing_password;
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
        Baixing_VideoEntity videoEntity = Baixing_VideoEntity(
            mBaixing_VideoUrl: "https://hellokidweb.kouyujie.cn/long.mp4",
            mBaixing_VideoName: item["title"]
        );
        GoRouter.of(context).push("/video", extra: videoEntity);
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
