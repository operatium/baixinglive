import '../api/baixing_api_background.dart';
import '../api/baixing_api_flutter.dart';
import '../api/baixing_api_provider.dart';
import '../api/baixing_api_thirdapi.dart';

import 'baixing_cover_widget.dart';
import 'baixing_icon_widget.dart';

class Baixing_UserBaseInfo extends StatelessWidget {
  final VoidCallback mBaixing_clickSwichAccount;
  final VoidCallback mBaixing_clickAvtar;

  Baixing_UserBaseInfo({
    super.key,
    required this.mBaixing_clickSwichAccount,
    required this.mBaixing_clickAvtar,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<Baixing_AccountModel>();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 用户头像
          GestureDetector(
            onTap: mBaixing_clickAvtar,
            child: Container(
              width: 60.w,
              height: 60.w,
              decoration: Baixing_BackGround.baixing_getCircle(),
              child: ClipOval(
                child: Baixing_CoverWidget(
                  mBaixing_url: model.baixing_getAvatar(),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  model.baixing_getNickName(),
                  style: Theme.of(context).textTheme.titleSmall,
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
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall!.copyWith(color: Colors.black),
                ),
              ],
            ),
          ),
          // 切换账号按钮
          GestureDetector(
            onTap: mBaixing_clickSwichAccount,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.w),
              decoration: Baixing_BackGround.baixing_getRoundedRectangularOutLine(),
              child: Text(
                '切换账号',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
