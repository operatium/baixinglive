import 'package:flutter/cupertino.dart';

class Baixing_LivePageScene extends StatefulWidget {
  const Baixing_LivePageScene({super.key});

  @override
  State<Baixing_LivePageScene> createState() => _Baixing_LivePageSceneState();
}

class _Baixing_LivePageSceneState extends State<Baixing_LivePageScene> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CupertinoSlidingSegmentedControl<int>(
        children: {
          0:Text('直播'),
          1:Text('消息'),
          2:Text('关注'),
          3:Text('我的'),
        },
        onValueChanged: (value) {},
      ),
    );
  }
}
