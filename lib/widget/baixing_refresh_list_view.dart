import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef Baixing_onRefreshBuilder = Future<void> Function(String data);
typedef Baixing_onLoadBuilder = Future<bool> Function(String data);
typedef Baixing_ItemCountBuilder =
    int Function(BuildContext context, String data);

class Baixing_RefreshListView extends StatefulWidget {
  Baixing_onRefreshBuilder mBaixing_onRefresh;
  NullableIndexedWidgetBuilder mBaixing_itemBuilder;
  Baixing_ItemCountBuilder mBaixing_getItemCount;
  SliverGridDelegateWithFixedCrossAxisCount mBaixing_gridDelegate;
  Baixing_onLoadBuilder mBaixing_onLoad;
  String mBaixing_data;

  Baixing_RefreshListView({
    Key? key,
    required this.mBaixing_onRefresh,
    required this.mBaixing_itemBuilder,
    required this.mBaixing_getItemCount,
    required this.mBaixing_gridDelegate,
    required this.mBaixing_onLoad,
    required this.mBaixing_data,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Baixing_RefreshListViewState();
  }
}

class _Baixing_RefreshListViewState extends State<Baixing_RefreshListView> {
  final _indicatorController = IndicatorController();
  bool _loading = false;
  final ScrollController _scrollController = ScrollController();
  bool _mBaixing_isBottom = false;
  int _time = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        NotificationListener(
          onNotification: (ScrollNotification notification) {
            _handleScroll(context, notification, widget.mBaixing_data);
            return false;
          },
          child: _getRefreshIndicator(
            child: GridView.builder(
              controller: _scrollController,
              gridDelegate: widget.mBaixing_gridDelegate,
              itemBuilder: widget.mBaixing_itemBuilder,
              itemCount: widget.mBaixing_getItemCount(
                context,
                widget.mBaixing_data,
              ),
            ),
          ),
        ),
        _getFootView(context),
      ],
    );
  }

  Widget _getRefreshIndicator({required Widget child}) {
    return CustomMaterialIndicator(
      onRefresh: () async {
        _mBaixing_isBottom = false;
        return await widget.mBaixing_onRefresh(widget.mBaixing_data);
      },
      controller: _indicatorController,
      backgroundColor: Colors.white,
      durations: RefreshIndicatorDurations(
        cancelDuration: const Duration(milliseconds: 300),
        settleDuration: const Duration(milliseconds: 300),
        finalizeDuration: const Duration(milliseconds: 300),
        completeDuration: const Duration(milliseconds: 300),
      ),
      child: child,
    );
  }

  void scroll() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.offset + 30.w,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _handleScroll(
    BuildContext context,
    ScrollNotification notification,
    String data,
  ) async {
    if (notification is ScrollEndNotification &&
        !_loading &&
        notification.metrics.pixels == notification.metrics.maxScrollExtent) {
      final t = DateTime.now().millisecondsSinceEpoch - _time;
      if(t > 1000) {
        _time = DateTime.now().millisecondsSinceEpoch;
      } else {
        return;
      }
      setState(() {
        _loading = true;
      });
      if (_mBaixing_isBottom) {
        Future.delayed(
          Duration(milliseconds: 500),
          () => setState(() {
            _loading = false;
          }),
        );
        return;
      }
      bool r = await widget.mBaixing_onLoad(data);
      if (r) {
        scroll();
      }
      setState(() {
        _mBaixing_isBottom = !r;
        _loading = false;
      });
    }
  }

  Widget _getFootView(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Visibility(
        visible: _loading,
        child: Container(
          color: Colors.grey,
          height: 30.w,
          child: Center(
            child: Text(
              _mBaixing_isBottom ? "没有更多了" : "正在加载...",
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
          ),
        ),
      ),
    );
  }
}
