import 'dart:math' as math;

import 'package:baixinglive/entity/baixing_live_room_entity.dart';
import 'package:baixinglive/provider/baixing_live_room_list_model.dart';
import 'package:baixinglive/widget/baixing_cover_widget.dart';
import 'package:baixinglive/widget/baixing_refresh_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class Baixing_LiveRoomListFragment extends StatefulWidget {
  final String mBaixing_title;

  const Baixing_LiveRoomListFragment({Key? key, required this.mBaixing_title})
    : super(key: key);

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
    print("yyx- ${widget.mBaixing_title} nowList: ${nowList.length}");
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
    return Baixing_RefreshListView(
      mBaixing_onRefresh: (String data) async {
        Tuple2<bool, List<Baixing_LiveRoomEntity>> result = await model
            .requestFirstLiveRoomList(data);
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
      mBaixing_itemBuilder: (BuildContext context, int index) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double width = constraints.maxWidth / 2 - 10.w;
            final Baixing_LiveRoomEntity entity = model.getList(title)[index];
            return _baixing_getRoundedCornerImageView(width, entity);
          },
        );
      },
      mBaixing_data: title,
      mBaixing_getItemCount: (context, data) {
        return model.getList(data).length;
      },
      mBaixing_gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
      ),
      mBaixing_onLoad: (String data) async {
        Tuple2<bool, List<Baixing_LiveRoomEntity>> result = await model
            .requestNextLiveRoomList(data);
        if (result.item1 && result.item2.isEmpty) {
          return false;
        }
        return true;
      },
    );
  }

  Widget _baixing_getRoundedCornerImageView(
    double width,
    Baixing_LiveRoomEntity entity,
  ) {
    return Container(
      margin: EdgeInsets.only(left: 10.w, top: 10.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(width / 10),
        child: Baixing_CoverWidget(mBaixing_url: entity.mBaixing_room_cover),
      ),
    );
  }

  void _setState({
    bool isLoading = false,
    bool isError = false,
    bool isEmpty = false,
    bool isListView = false,
  }) {
    if (_mBaixing_showListView == null) return;
    print(
      "yyx- _setState isLoading:$isLoading isError:$isError isEmpty:$isEmpty isListView:$isListView",
    );
    setState(() {
      _mBaixing_isLoading = isLoading;
      _mBaixing_isError = isError;
      _mBaixing_isEmpty = isEmpty;
      _mBaixing_showListView = isListView;
    });
  }
}
