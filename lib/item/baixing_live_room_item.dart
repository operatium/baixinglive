import 'package:baixinglive/entity/baixing_live_room_entity.dart';
import 'package:baixinglive/widget/baixing_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widget/baixing_cover_widget.dart';

class Baixing_LiveRoomItem extends StatefulWidget {
  Baixing_LiveRoomEntity mBaixing_liveRoomEntity;

  Baixing_LiveRoomItem({Key? key, required this.mBaixing_liveRoomEntity})
    : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Baixing_LiveRoomItemState();
  }
}

class _Baixing_LiveRoomItemState
    extends State<Baixing_LiveRoomItem> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          child: Stack(
            children: [
              _baixing_getRoundedCornerImageView(context),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _baixing_getTopTagView("跳舞Top10"),
                  const Spacer(),
                  _baixing_getUserView(
                    widget.mBaixing_liveRoomEntity.mBaixing_room_name,
                    widget.mBaixing_liveRoomEntity.mBaixing_girl_name,
                    widget.mBaixing_liveRoomEntity.mBaixing_audience_count,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _baixing_getRoundedCornerImageView(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.w),
        child: Baixing_CoverWidget(
          mBaixing_url: widget.mBaixing_liveRoomEntity.mBaixing_room_cover,
        ),
      ),
    );
  }

  Widget _baixing_getTopTagView(String tag) {
    return Container(
      margin: EdgeInsets.only(top: 6.w, left: 6.w),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.w),
      decoration: Baixing_BackGround.baixing_getRoundedRectangular_K002(),
      child: IntrinsicWidth(
        child: Text(
          tag,
          style: Theme.of(
            context,
          ).textTheme.labelSmall!.copyWith(color: Colors.white, fontSize: 8.sp),
        ),
      ),
    );
  }

  Widget _baixing_getUserView(String name, String city, int audience) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.w),
      decoration: BoxDecoration(color: Color(0x33000000)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: Theme.of(
              context,
            ).textTheme.labelMedium!.copyWith(color: Colors.white),
          ),
          Row(
            children: [
              Text(
                city,
                style: Theme.of(
                  context,
                ).textTheme.labelSmall!.copyWith(color: Colors.white),
              ),
              const Spacer(),
              Text(
                _getNumStr(audience),
                style: Theme.of(
                  context,
                ).textTheme.labelMedium!.copyWith(color: Colors.white),
              ),
              Text(
                "人观看",
                style: Theme.of(
                  context,
                ).textTheme.labelSmall!.copyWith(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getNumStr(int num) {
    if (num > 9999) {
      return "9999+";
    }
    return num.toString();
  }
}
