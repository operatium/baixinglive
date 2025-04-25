import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Baixing_LiveFragment extends StatefulWidget {
  const Baixing_LiveFragment({super.key});

  @override
  State<Baixing_LiveFragment> createState() => _Baixing_LiveFragmentState();
}

class _Baixing_LiveFragmentState extends State<Baixing_LiveFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 4,
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: const Center(child: Text('99直播')),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  tabs: const [
                    Tab(text: '正在直播'),
                    Tab(text: '直播间'),
                    Tab(text: '正在直播1'),
                    Tab(text: '直播间2'),
                  ],
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.black,
                  isScrollable: true,
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Container(
                      color: Colors.white,
                      child: const Center(child: Text('正在直播1')),
                    ),
                    Container(
                      color: Colors.white,
                      child: const Center(child: Text('直播间2')),
                    ),
                    Container(
                      color: Colors.white,
                      child: const Center(child: Text('直播间3')),
                    ),
                    Container(
                      color: Colors.white,
                      child: const Center(child: Text('直播间4')),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
