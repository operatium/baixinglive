import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'baixing_cover_widget.dart';

typedef Baixing_ItemCountBuilder = int Function(BuildContext context);
typedef Baixing_ItemCoverUrlBuilder = String Function(BuildContext context, int index);

class Baixing_DoubleListView extends StatefulWidget {
  Baixing_ItemCountBuilder mBaixing_itemCount;
  Baixing_ItemCoverUrlBuilder mBaixing_itemCoverUrlBuilder;
  ScrollController mBaixing_ScrollController;
  final String mBaixing_title;

  Baixing_DoubleListView({
    required this.mBaixing_title,
    required this.mBaixing_itemCount,
    required this.mBaixing_itemCoverUrlBuilder,
    required this.mBaixing_ScrollController
  });

  @override
  State<StatefulWidget> createState() {
    return _Baixing_DoubleListViewState();
  }
}

class _Baixing_DoubleListViewState extends State<Baixing_DoubleListView> {

  Widget _baixing_getRoundedCornerImageView(double width, int index) {
    return Container(
      margin: EdgeInsets.only(left: 10.w, top: 10.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(width / 10),
        child: Baixing_CoverWidget(
          mBaixing_url: widget.mBaixing_itemCoverUrlBuilder(context, index),
        ),
      ),
    );
  }

  NullableIndexedWidgetBuilder _baixing_createItemBuilder() {
    return (BuildContext context, int index) =>
        LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final double width = constraints.maxWidth / 2 - 10.w;
              return _baixing_getRoundedCornerImageView(width, index);
            });
  }

  SliverGridDelegate _baixing_createGridDelegate() {
    return const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 1.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverVisibility(
            visible: true,
            sliver: Container(
              height: 30.w,
              color: Color(0xffdddddd),
              child: Center(
                child: Text("到底了", style: TextStyle(color: Color(0xff333333), fontSize: 14.sp),),
              ),
            )
        ),
        SliverGrid.builder(
            gridDelegate: _baixing_createGridDelegate(),
            itemBuilder: _baixing_createItemBuilder(),
            itemCount: widget.mBaixing_itemCount(context),
        ),

      ],
    );
  }
}
