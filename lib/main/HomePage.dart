import 'package:flutter/material.dart';
import 'BottomNavBar.dart';
import 'LuckyWheelBanner.dart';
import 'TeenModeNotice.dart';
import 'VideoCard.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  bool _teenModeDisabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            const Text(
              '推荐',
              style: TextStyle(
                color: Colors.purple,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.search, color: Colors.black),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.access_time, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // 幸运大转盘广告
          LuckyWheelBanner(
            onTap: () {
              // 处理点击抽奖按钮的逻辑
              print('开始抽奖');
            },
          ),
          
          // 青少年模式提示
          if (_teenModeDisabled)
            TeenModeNotice(
              onClose: () {
                setState(() {
                  _teenModeDisabled = false;
                });
              },
            ),
          
          // 视频网格
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                String tag = index % 2 == 0 ? '年度巅峰季军' : '跳舞中';
                return VideoCard(
                  index: index,
                  tag: tag,
                  hostName: '招财姐姐',
                  category: '么么星球',
                  viewCount: '66人看过',
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}