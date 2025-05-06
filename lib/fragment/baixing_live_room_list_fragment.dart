import 'dart:math' as math;

import 'package:baixinglive/entity/baixing_live_room_entity.dart';
import 'package:baixinglive/provider/baixing_live_room_list_model.dart';
import 'package:baixinglive/widget/baixing_cover_widget.dart';
import 'package:baixinglive/widget/baixing_empty_widget.dart';
import 'package:baixinglive/widget/baixing_head_foot_grid_view.dart';
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
    if (nowList.isEmpty) {
      _baixing_requestData(context);
    } else {
      mBaixing_EmptyControl.baixing_changeState(isContentLayout: true);
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
    print("yyx- _baixing_initData title: ${widget.mBaixing_title}");
    mBaixing_EmptyControl.baixing_changeState(isLoading: true);
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
    return Baixing_HeadFootGridView(
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
      ),
      mBaixing_getItemCount: _baixing_getItemCount,
      mBaixing_data: widget.mBaixing_title,
      mBaixing_itemBuilder: _baixing_getRoundedCornerImageView,
    );
  }

  int _baixing_getItemCount() {
    Baixing_LiveRoomListModel model = context.watch();
    final len = model.getList(widget.mBaixing_title).length;
    return math.max(len, widget.mBaixing_minItemCount);
  }

  Widget _baixing_getRoundedCornerImageView(BuildContext context, int index) {
    Baixing_LiveRoomListModel model = context.watch();
    final list = model.getList(widget.mBaixing_title);
    final length = list.length;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double width = constraints.maxWidth / 2 - 10.w;
        if (index >= length) {
          return Container();
        } else {
          final Baixing_LiveRoomEntity entity = list[index];
          return Container(
            margin: EdgeInsets.only(
              top: 10.w,
              bottom: _getBottom(index, length),
              left: (index % 2 == 0) ? 10.w : 0,
              right: (index % 2 == 1) ? 10.w : 0,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(width / 10),
              child: Baixing_CoverWidget(
                mBaixing_url: entity.mBaixing_room_cover,
              ),
            ),
          );
        }
      },
    );
  }

  double _getBottom(int index, int length) {
    if (length % 2 == 0) {
      if (index == length - 1) {
        return 10.w;
      }
      if (index == length - 2) {
        return 10.w;
      }
    } else {
      if (index == length - 1) {
        return 10.w;
      }
    }
    return 0;
  }
}
