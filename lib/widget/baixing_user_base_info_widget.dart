import 'package:baixinglive/provider/baixing_account_model.dart';
import 'package:baixinglive/widget/baixing_background.dart';
import 'package:baixinglive/widget/baixing_cover_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'baixing_icon_widget.dart';

class Baixing_UserBaseInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<Baixing_AccountModel>();
    return SizedBox(
      height: 80.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 用户头像
          Container(
            width: 60.w,
            height: 60.w,
            decoration: Baixing_BackGround.baixing_getCircle(),
            child: ClipOval(
              child: Baixing_CoverWidget(
                mBaixing_url: model.baixing_getAvatar(),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 用户昵称
                Text(
                  model.baixing_getNickName(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 4.w),
                // 用户等级标签
                Row(
                  children:
                      model.baixing_getUserTag().map((String tag) {
                        return SizedBox(
                          width: 45.w,
                          height: 15.w,
                          child: Baixing_IconWidget(
                            mBaixing_url: tag,
                            mBaixing_imageSourceType: ImageSourceType.local,
                          ),
                        );
                      }).toList(),
                ),
                SizedBox(height: 4.w),
                // 用户 ID
                Text(
                  "ID:${model.baixing_getUserId()}",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
          // 切换账号按钮
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.w),
              margin: EdgeInsets.only(bottom: 15.w),
              decoration: Baixing_BackGround.baixing_getRoundedRectangularOutLine(),
              child: Text(
                '切换账号和状态',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
