import 'dart:math' as math;

import 'package:baixinglive/entity/baixing_live_room_entity.dart';
import 'package:baixinglive/provider/baixing_live_room_list_model.dart';
import 'package:baixinglive/widget/baixing_cover_widget.dart';
import 'package:baixinglive/widget/baixing_double_list_view.dart';
import 'package:baixinglive/widget/baixing_refresh_list_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

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
  bool _loading = false;
  ScrollController _scrollController = ScrollController();
  bool _mBaixing_isBottom = false;

  void scroll() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.offset + 30,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _handleScroll(
    ScrollNotification notification,
    Baixing_LiveRoomListModel model,
    String title,
  ) async {
    if (notification is ScrollEndNotification &&
        !_loading &&
        notification.metrics.pixels == notification.metrics.maxScrollExtent) {
      setState(() {
        _loading = true;
      });
      bool r = await model.requestNextLiveRoomList(title);
      if (r) {
        scroll();
      }
      setState(() {
        _mBaixing_isBottom = !r;
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      context.read<Baixing_LiveRoomListModel>().requestFirstLiveRoomList(
        widget.mBaixing_title,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Baixing_LiveRoomListModel model = context.watch();
    final title = widget.mBaixing_title;
    return Stack(
      children: [
        NotificationListener(
          onNotification: (ScrollNotification notification) {
            _handleScroll(notification, model, title);
            return false;
          },
          child: Baixing_RefreshListView(
            mBaixing_onRefresh: (control) async {
              model.requestFirstLiveRoomList(widget.mBaixing_title);
            },
            child: Baixing_DoubleListView(
              mBaixing_ScrollController: _scrollController,
              mBaixing_title: title,
              mBaixing_itemCount: (context) {
                return model.getList(title).length;
              },
              mBaixing_itemCoverUrlBuilder: (context, index) {
                return model.getList(title)[index].mBaixing_room_cover;
              },
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Visibility(
            visible: _loading,
            child: Container(
              color: Colors.grey,
              height: 30.w,
              child: Center(
                child: Text(
                  _mBaixing_isBottom ? "没有更多了" : "正在加载..$_loading",
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
