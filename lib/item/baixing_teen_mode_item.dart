import 'package:baixinglive/widget/baixing_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../api/baixing_api_background.dart';

class Baixing_TeenModeItem extends StatelessWidget {
  String mBaixing_cover;
  String mBaixing_time;
  String mBaixing_name;

  Baixing_TeenModeItem({
    Key? key,
    required this.mBaixing_cover,
    required this.mBaixing_time,
    required this.mBaixing_name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.w),
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: Baixing_IconWidget(
              mBaixing_url: mBaixing_cover,
              mBaixing_imageSourceType: ImageSourceType.network,
              mBaixing_boxFit: BoxFit.cover,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 6.w, left: 6.w),
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.w),
                decoration: Baixing_BackGround.baixing_getRoundedRectangular(
                  radius: 8.w,
                  color: Color(0x66000000),
                ),
                child: IntrinsicWidth(
                  child: Text(
                    mBaixing_time,
                    style: textTheme.labelSmall!.copyWith(
                      color: Colors.white,
                      fontSize: 8.sp,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Container(
                height: 34.h,
                width: double.infinity,
                color: Color(0x33000000),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.w),
                child: Text(
                  mBaixing_name,
                  textAlign: TextAlign.start,
                  style: textTheme.labelMedium!.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
