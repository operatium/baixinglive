import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:tuple/tuple.dart';

class Baixing_HeadFootGridView extends StatefulWidget {
  AsyncCallback mBaixing_onRefresh;
  Future<Tuple2<bool, bool>> Function() mBaixing_onLoad;

  NullableIndexedWidgetBuilder mBaixing_itemBuilder;
  int Function() mBaixing_getItemCount;
  SliverGridDelegateWithFixedCrossAxisCount mBaixing_gridDelegate;
  String mBaixing_data;

  Baixing_HeadFootGridView({
    Key? key,
    required this.mBaixing_onRefresh,
    required this.mBaixing_onLoad,
    required this.mBaixing_itemBuilder,
    required this.mBaixing_getItemCount,
    required this.mBaixing_gridDelegate,
    required this.mBaixing_data,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Baixing_HeadFootGridViewState();
  }
}

class _Baixing_HeadFootGridViewState extends State<Baixing_HeadFootGridView> {
  final EasyRefreshController _baixing_controller = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  @override
  Widget build(BuildContext context) {
    return EasyRefresh.builder(
      controller: _baixing_controller,
      header: CupertinoHeader(),
      footer: ClassicFooter(),
      onRefresh: () async {
        await widget.mBaixing_onRefresh();
        _baixing_controller.finishRefresh();
        _baixing_controller.resetFooter();
      },
      onLoad: () async {
        Tuple2<bool, bool> result = await widget.mBaixing_onLoad();
        IndicatorResult type = result.item1 ? IndicatorResult.success: IndicatorResult.fail;
        if(result.item1 && result.item2) {
          type = IndicatorResult.noMore;
        }
        _baixing_controller.finishLoad(type);
      },
      childBuilder: (BuildContext context, ScrollPhysics physics) {
        return GridView.builder(
          itemBuilder: widget.mBaixing_itemBuilder,
          itemCount: widget.mBaixing_getItemCount(),
          physics: physics,
          gridDelegate: widget.mBaixing_gridDelegate,
        );
      },
    );
  }
}
