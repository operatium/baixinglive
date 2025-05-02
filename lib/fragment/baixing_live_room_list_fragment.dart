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
    return Baixing_RefreshListView(
      mBaixing_onRefresh: (String data) {
        return model.requestFirstLiveRoomList(data);
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
      mBaixing_onLoad: (String data) {
        return model.requestNextLiveRoomList(data);
      },
    );
  }

  Widget _baixing_getRoundedCornerImageView(double width, Baixing_LiveRoomEntity entity) {
    return Container(
      margin: EdgeInsets.only(left: 10.w, top: 10.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(width / 10),
        child: Baixing_CoverWidget(
          mBaixing_url: entity.mBaixing_room_cover,
        ),
      ),
    );
  }
}
