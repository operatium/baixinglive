import 'dart:math' as math;

import 'package:baixinglive/entity/baixing_live_room_entity.dart';
import 'package:baixinglive/provider/baixing_live_room_list_model.dart';
import 'package:baixinglive/widget/baixing_cover_widget.dart';
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
  bool? _mBaixing_isLoading = true;
  bool? _mBaixing_isEmpty = false;
  bool? _mBaixing_isError = false;
  bool? _mBaixing_showListView = false;

  @override
  void initState() {
    super.initState();
    print("yyx- ${widget.mBaixing_title} initState");
    _mBaixing_isLoading = _mBaixing_isLoading ?? true;
    _mBaixing_isEmpty = _mBaixing_isEmpty ?? false;
    _mBaixing_isError = _mBaixing_isEmpty ?? false;
    _mBaixing_showListView = _mBaixing_showListView ?? false;
  }

  @override
  void dispose() {
    super.dispose();
    print("yyx- ${widget.mBaixing_title} dispose");
    _mBaixing_isLoading = null;
    _mBaixing_isError = null;
    _mBaixing_isEmpty = null;
    _mBaixing_showListView = null;
  }

  @override
  Widget build(BuildContext context) {
    print("yyx- ${widget.mBaixing_title} build");
    if (_mBaixing_showListView == null) {
      return const Placeholder();
    }
    final title = widget.mBaixing_title;
    final nowList = context.read<Baixing_LiveRoomListModel>().getList(title);
    if (nowList.isEmpty) {
      _baixing_initData(context);
    } else {
      _setState(isListView: true);
    }
    return LayoutBuilder(
      builder: (context, mConstraintType) {
        return Stack(
            children: [
              Visibility(
                visible: _mBaixing_isLoading!,
                child: Center(child: CircularProgressIndicator(value: null)),
              ),
              Visibility(
                visible: !_mBaixing_isLoading! && _mBaixing_showListView!,
                child: _baixing_getListView(context, title),
              ),
              Visibility(
                visible: !_mBaixing_isLoading! && _mBaixing_isError!,
                child: _baixing_getHitPage("请求失败", "重试", () {
                  _baixing_initData(context);
                }),
              ),
              Visibility(
                visible: !_mBaixing_isLoading! && _mBaixing_isEmpty!,
                child: _baixing_getHitPage("没有内容", "刷新", () {
                  _baixing_initData(context);
                }),
              ),
            ],
        );
      },
    );
  }

  void _baixing_initData(BuildContext context) async {
    print("yyx- _baixing_initData title: ${widget.mBaixing_title}");
    _setState(isLoading: true);
    Baixing_LiveRoomListModel model = context.read();
    final result = await model.requestFirstLiveRoomList(widget.mBaixing_title);
    if (_mBaixing_isLoading != null) {
      if (result.item1 && result.item2.isEmpty) {
        _setState(isEmpty: true);
        return;
      }
      if (result.item1) {
        _setState(isListView: true);
        return;
      }
      _setState(isError: true);
    }
  }

  Widget _baixing_getHitPage(
    String message,
    String button,
    VoidCallback onPressed,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("images/baixing_99.webp"),
          Text(message),
          ElevatedButton(onPressed: onPressed, child: Text(button)),
        ],
      ),
    );
  }

  Widget _baixing_getListView(BuildContext context, String title) {
    Baixing_LiveRoomListModel model = context.watch();
    return Baixing_HeadFootGridView(
      mBaixing_onRefresh: () async {
        Tuple2<bool, List<Baixing_LiveRoomEntity>> result = await model
            .requestFirstLiveRoomList(widget.mBaixing_title);
        if (result.item1 && result.item2.isEmpty) {
          _setState(isEmpty: true);
          return;
        }
        if (result.item1) {
          _setState();
          return;
        }
        _setState(isError: true);
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

  void _setState({
    bool isLoading = false,
    bool isError = false,
    bool isEmpty = false,
    bool isListView = false,
  }) {
    if (_mBaixing_showListView == null) return;
    setState(() {
      _mBaixing_isLoading = isLoading;
      _mBaixing_isError = isError;
      _mBaixing_isEmpty = isEmpty;
      _mBaixing_showListView = isListView;
    });
  }
}
