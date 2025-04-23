import 'package:baixinglive/scene/baixing_livepage_scene.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Baixing_HomeScene extends StatefulWidget {
  const Baixing_HomeScene({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Baixing_HomeSceneState();
  }
}

class _Baixing_HomeSceneState extends State<Baixing_HomeScene> {
  Widget getPage(int index) {
    switch (index) {
      case 0:
        return const Baixing_LivePageScene();
      default:
        return const Baixing_HomeScene();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
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
        currentIndex: 0,
        backgroundColor: Color(0xfff6f9fc),
        activeColor: CupertinoColors.systemPurple,
        inactiveColor: Color(0xff333333),
      ),
      tabBuilder: (context, index) {
        return getPage(index);
      },
    );
  }
}
