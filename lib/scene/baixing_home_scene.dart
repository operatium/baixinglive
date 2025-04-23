import 'package:baixinglive/scene/baixing_login_scene.dart';
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
        onTap: (index) {},
        backgroundColor: Color(0xfff6f9fc),
        activeColor: CupertinoColors.systemBlue,
        inactiveColor: CupertinoColors.systemGrey,
      ),
      tabBuilder: (context, index) {
        return const Baixing_LoginScene();
      },
    );
  }
}
