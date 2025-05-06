import 'package:baixinglive/entity/baixing_final_entity.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';
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
  final _headController = IndicatorController();
  bool _mBaixing_isFootLoading = false;
  bool _mBaixing_isFootProgressbar = false;
  final ScrollController _scrollController = ScrollController();
  bool _mBaixing_isBottom = false;
  _Baixing_FootScrollState? _mBaixing_footScrollState;

  @override
  Widget build(BuildContext context) {
    _mBaixing_footScrollState ??= _Baixing_FootScrollState(
      mBaixing_loading: (b) {
        setState(() {
          _mBaixing_isFootLoading = b;
        });
        if (b) {
          _headController.disableRefresh();
        } else {
          _headController.enableRefresh();
        }
      },
      mBaixing_onLoad: () async {
        if (_mBaixing_isBottom) return;
        setState(() {
          _mBaixing_isFootProgressbar = true;
        });
        _mBaixing_isBottom =
            !await widget.mBaixing_onLoad(widget.mBaixing_data);
        if (!_mBaixing_isBottom) {
          scroll();
        }
        setState(() {
          _mBaixing_isFootProgressbar = false;
        });
      },
    );
    return Stack(
      children: [
        NotificationListener(
          onNotification: (ScrollNotification notification) {
            _mBaixing_footScrollState!.handleScroll(context, notification);
            return false;
          },
          child: _getRefreshIndicator(
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
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
        final isscroll = await widget.mBaixing_onRefresh(widget.mBaixing_data);
        return isscroll;
      },
      controller: _headController,
      backgroundColor: Colors.white,
      durations: RefreshIndicatorDurations(
        cancelDuration: Baixing_300ms,
        settleDuration: Baixing_300ms,
        finalizeDuration: Baixing_300ms,
        completeDuration: Baixing_300ms,
      ),
      child: child,
    );
  }

  void scroll() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.offset + 30.w,
        duration: Baixing_300ms,
        curve: Curves.easeOut,
      );
    }
  }

  Widget _getFootView(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Visibility(
        visible: _mBaixing_isFootLoading || _mBaixing_isFootProgressbar,
        child: Container(
          color: Colors.black,
          height: 30.w,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _mBaixing_isBottom ? "到底了" : "加载下一页",
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                ),
                SizedBox(width: 8.w),
                Visibility(
                  visible: _mBaixing_isFootProgressbar,
                  child: CupertinoActivityIndicator(
                    radius: 6.w,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum RollingDirection {
  UP(1),
  DOWN(-1),
  STOP(0);

  final int direction;

  const RollingDirection(this.direction);
}

class _Baixing_FootScrollState {
  bool mBaixing_lastElementScrollUp = false;
  bool mBaixing_lastElementBackBottom = false;
  void Function(bool) mBaixing_loading;
  AsyncCallback mBaixing_onLoad;
  RollingDirection mBaixing_direction = RollingDirection.STOP;
  bool mBaixing_working = false;
  bool mBaixing_wantRunOnLoad = false;

  _Baixing_FootScrollState({
    required this.mBaixing_onLoad,
    required this.mBaixing_loading,
  });

  void handleScroll(
    BuildContext context,
    ScrollNotification notification,
  ) async {
    if (notification is UserScrollNotification) {
      if (notification.direction == ScrollDirection.reverse) {
        mBaixing_direction = RollingDirection.UP;
      }
      if (notification.direction == ScrollDirection.forward) {
        mBaixing_direction = RollingDirection.DOWN;
      }
      if (notification.direction == ScrollDirection.idle) {
        mBaixing_direction = RollingDirection.STOP;
      }
    }
    mBaixing_lastElementScrollUp =
        notification.metrics.pixels > notification.metrics.maxScrollExtent;
    mBaixing_lastElementBackBottom =
        notification.metrics.pixels == notification.metrics.maxScrollExtent;
    if (notification is ScrollStartNotification) {
      mBaixing_working = true;
    }
    if (notification is ScrollEndNotification) {
      mBaixing_working = false;
      mBaixing_loading(false);
      if (mBaixing_wantRunOnLoad) {
        mBaixing_wantRunOnLoad = false;
        mBaixing_direction = RollingDirection.STOP;
        mBaixing_onLoad();
      }
    }
    if (mBaixing_working) {
      if (mBaixing_lastElementScrollUp &&
          mBaixing_direction == RollingDirection.UP) {
        mBaixing_wantRunOnLoad = true;
        mBaixing_loading(true);
      }
      if (mBaixing_wantRunOnLoad &&
          mBaixing_direction == RollingDirection.DOWN) {
        mBaixing_wantRunOnLoad = false;
      }
    }
  }
}
