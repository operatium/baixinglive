import 'package:baixinglive/entity/baixing_final_entity.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  final _indicatorController = IndicatorController();
  bool _mBaixing_isLoading = false;
  final ScrollController _scrollController = ScrollController();
  bool _mBaixing_isBottom = false;
  final _mBaixing_Debouncer = Debouncer();
  bool _mBaixing_upScroll = false;

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
        return await widget.mBaixing_onRefresh(widget.mBaixing_data);
      },
      controller: _indicatorController,
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

  void _handleScroll(
      BuildContext context,
      ScrollNotification notification,
      String data,
      ) async {
    _mBaixing_Debouncer.debounce(duration: Baixing_1000ms,
        onDebounce: () {
          if (notification is ScrollUpdateNotification) {
            final scrollDelta = notification.scrollDelta;
            _mBaixing_upScroll = (scrollDelta != null && scrollDelta > 0); // 上拉
          }
        });
    final bottomUp = notification.metrics.pixels >
        notification.metrics.maxScrollExtent; //底部上滚
    if (bottomUp && _mBaixing_upScroll && !_mBaixing_isLoading) {
      _mBaixing_Debouncer.debounce(
        duration: Baixing_1000ms,
        type: BehaviorType.leadingEdge,
        onDebounce: () async {
          print("yyx- 触发上拉2");
          setState(() => _mBaixing_isLoading = true);
          if (_mBaixing_isBottom) {
            delay500(() => setState(() => _mBaixing_isLoading = false));
            return;
          }
          bool r = await widget.mBaixing_onLoad(data);
          if (r) {
            scroll();
          }
          setState(() {
            _mBaixing_isBottom = !r;
            _mBaixing_isLoading = false;
          });
        },
      );
    }
  }

  Widget _getFootView(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Visibility(
        visible: _mBaixing_isLoading,
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
