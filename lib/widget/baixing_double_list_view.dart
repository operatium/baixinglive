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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10.w),
      child: GridView.builder(
        controller: widget.mBaixing_ScrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
        ),
        itemCount: widget.mBaixing_itemCount(context),
        itemBuilder: (context, index) {
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final double width = constraints.maxWidth / 2 - 10.w;
              return Container(
                margin: EdgeInsets.only(left: 10.w, top: 10.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(width / 10),
                  child: Baixing_CoverWidget(
                    mBaixing_url: widget.mBaixing_itemCoverUrlBuilder(context, index),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}