import 'package:baixinglive/compat/baixing_toast.dart';
import 'package:baixinglive/provider/baixing_live_streaming_column.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'baixing_live_room_list_fragment.dart';

class Baixing_LiveFragment extends StatefulWidget {
  const Baixing_LiveFragment({super.key});

  @override
  State<Baixing_LiveFragment> createState() => _Baixing_LiveFragmentState();
}

class _Baixing_LiveFragmentState extends State<Baixing_LiveFragment>
    with TickerProviderStateMixin {
  TabController? _tabController = null;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      context
          .read<Baixing_LiveStraeamingColumnModel>()
          .baixing_getLiveSteamingColumn();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Baixing_LiveStraeamingColumnModel liveColumnModel = context.watch();
    _tabController = TabController(
      length: _getTabs(liveColumnModel).length,
      vsync: this,
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 40.w,
              margin: EdgeInsets.only(left: 15.w, right: 15.w),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        showSearch(context: context, delegate: CustomSearchDelegate());
                      },
                      child: Container(
                        height: 30.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20.w)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Icon(Icons.search, color: Color(0xff888888),),
                            ),
                            Text("搜索99直播间，视觉盛宴", style: TextStyle(color: Color(0xff888888)),),
                          ],
                        ),
                      ),
                    )
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15.w),
                    child: Icon(Icons.history_rounded),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40.w,
              child: TabBar(
                tabAlignment: TabAlignment.start,
                tabs: _getTabs(liveColumnModel),
                controller: _tabController,
                isScrollable: true,
                indicatorColor: Color(0xffFF0000),
                labelColor: Color(0xff000000),
                labelStyle: TextStyle(fontSize: 16.sp),
                unselectedLabelColor: Color(0xff888888),
                unselectedLabelStyle: TextStyle(fontSize: 13.sp),
                indicatorWeight: 3.w,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: UnderlineTabIndicator(
                  borderRadius: BorderRadius.all(Radius.circular(9)),
                  borderSide: BorderSide(color: Colors.red, width: 3.w),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: _getPage(liveColumnModel),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getTabs(Baixing_LiveStraeamingColumnModel model) {
    return model.columnList.map((String name) => Text(name)).toList();
  }

  List<Widget> _getPage(Baixing_LiveStraeamingColumnModel model) {
    return model.columnList
        .map((String name) => Baixing_LiveRoomListFragment(title: name))
        .toList();
  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(child: Text('搜索结果: $query'));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(child: Text('搜索建议: $query'));
  }
}
