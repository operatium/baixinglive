import 'package:baixinglive/api/baixing_api.dart';
import 'package:baixinglive/fragment/baixing_live_page_fragment.dart';
import 'package:baixinglive/fragment/baixing_me_fragment.dart';

class Baixing_HomeScene extends StatefulWidget {
  const Baixing_HomeScene({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Baixing_HomeSceneState();
  }
}

class _Baixing_HomeSceneState extends State<Baixing_HomeScene> {
  var _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      baixing_showTeenagersHitDialog(context);
    });
  }

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
}
