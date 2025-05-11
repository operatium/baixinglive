import 'package:baixinglive/api/baixing_api.dart';
import 'package:baixinglive/api/baixing_api_thirdapi.dart';

import '../api/baixing_api_flutter.dart';

/**
 * @author yuyuexing
 * @date: 2025-05-11
 * @description: 待解锁标签组件
 */
class Baixing_TagWidget extends StatelessWidget {
  final double _mBaixing_icon_size = 60.w;
  final String mBaixing_tag_name;
  final bool mBaixing_is_lock;
  final IconData mBaixing_icon;

  Baixing_TagWidget({
    super.key,
    required this.mBaixing_tag_name,
    required this.mBaixing_is_lock,
    required this.mBaixing_icon,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: _mBaixing_icon_size + 20.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 图标部分
          Stack(
            alignment: Alignment.center,
            children: [
              // 圆形背景
              Container(
                width: _mBaixing_icon_size,
                height: _mBaixing_icon_size,
                decoration: BoxDecoration(
                  color: Color(0xFF444444),
                  shape: BoxShape.circle,
                ),
              ),
              // 音量图标
              Icon(mBaixing_icon, color: Color(0xFFE0C99B), size: 30.w),
              // 底部锁定标签
              mBaixing_is_lock
                  ? Positioned(bottom: 0, child: _baixing_lock(context))
                  : SizedBox(height: 0),
            ],
          ),
          SizedBox(height: 2.h),
          // 标签名称
          Text(
            mBaixing_tag_name,
            style: textTheme.labelSmall!.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  Widget _baixing_lock(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: Baixing_BackGround.baixing_getRoundedRectangularOutLine(
        borderColor: Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.lock, color: Colors.white, size: 8.w),
          SizedBox(width: 2.w),
          Text("待解锁", style: TextStyle(color: Colors.white, fontSize: 8.sp)),
        ],
      ),
    );
  }
}
