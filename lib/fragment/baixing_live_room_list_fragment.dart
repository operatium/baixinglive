import 'dart:math' as math;

import 'package:baixinglive/entity/baixing_live_room_entity.dart';
import 'package:baixinglive/provider/baixing_live_room_list_model.dart';
import 'package:baixinglive/widget/baixing_cover_widget.dart';
import 'package:baixinglive/widget/baixing_empty_widget.dart';
import 'package:baixinglive/widget/baixing_head_foot_grid_view.dart';
import 'package:baixinglive/widget/baixing_live_room_enter_widget.dart';
import 'package:baixinglive/widget/baixing_refresh_list_view.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class Baixing_LiveRoomListFragment extends StatefulWidget {
  final String mBaixing_title;
  int mBaixing_minItemCount;

  Baixing_LiveRoomListFragment({
    Key? key,
    required this.mBaixing_title,
    this.mBaixing_minItemCount = 0,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Baixing_LiveRoomListFragmentState();
  }
}

class _Baixing_LiveRoomListFragmentState
    extends State<Baixing_LiveRoomListFragment> {
  Baixing_EmptyControl mBaixing_EmptyControl = Baixing_EmptyControl();

  @override
  void initState() {
    super.initState();
    print("yyx- ${widget.mBaixing_title} initState");
  }

  @override
  void dispose() {
    super.dispose();
    print("yyx- ${widget.mBaixing_title} dispose");
  }

  @override
  Widget build(BuildContext context) {
    print("yyx- ${widget.mBaixing_title} build");
    final title = widget.mBaixing_title;
    final nowList = context.read<Baixing_LiveRoomListModel>().getList(title);
    mBaixing_EmptyControl.baixing_changeState(isContentLayout: true);
    if (nowList.isEmpty) {
      _baixing_requestData(context);
    }
    return Baixing_EmptyWidget(
      mBaixing_onPress: (str) {
        _baixing_requestData(context);
      },
      mBaixing_contentLayoutBuild:
          (context) => _baixing_getListView(context, widget.mBaixing_title),
      mBaixing_emptyControl: mBaixing_EmptyControl,
    );
  }

  void _baixing_requestData(BuildContext context) async {
    Baixing_LiveRoomListModel model = context.read();
    final result = await model.requestFirstLiveRoomList(widget.mBaixing_title);
    if (result.item1) {
      if (result.item2.isEmpty) {
        mBaixing_EmptyControl.baixing_changeState(isEmpty: true);
      } else {
        mBaixing_EmptyControl.baixing_changeState(isContentLayout: true);
      }
    } else {
      mBaixing_EmptyControl.baixing_changeState(isError: true);
    }
  }

  Widget _baixing_getListView(BuildContext context, String title) {
    Baixing_LiveRoomListModel model = context.watch();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      child: Baixing_HeadFootGridView(
        mBaixing_onRefresh: () async {
          _baixing_requestData(context);
        },
        mBaixing_onLoad: () async {
          Tuple2<bool, List<Baixing_LiveRoomEntity>> result = await model
              .requestNextLiveRoomList(widget.mBaixing_title);
          return Tuple2(result.item1, result.item2.isEmpty);
        },
        mBaixing_gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.w,
        ),
        mBaixing_getItemCount: _baixing_getItemCount,
        mBaixing_data: widget.mBaixing_title,
        mBaixing_itemBuilder: _baixing_getItem,
      ),
    );
  }

  int _baixing_getItemCount() {
    Baixing_LiveRoomListModel model = context.watch();
    final len = model.getList(widget.mBaixing_title).length;
    return math.max(len, widget.mBaixing_minItemCount);
  }

  Widget _baixing_getItem(BuildContext context, int index) {
    Baixing_LiveRoomListModel model = context.watch();
    final list = model.getList(widget.mBaixing_title);
    final entity = list[index];
    return Baixing_LiveRoomEnterWidget(mBaixing_liveRoomEntity: entity);
  }
}
