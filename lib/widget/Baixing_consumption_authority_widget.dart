import '../api/baixing_api.dart';
import '../api/baixing_api_flutter.dart';
import '../api/baixing_api_thirdapi.dart';

/**
 * @author yuyuexing
 * @date: 2025-05-11
 * @description: 财富称号控件，显示称号信息和解锁条件
 */
class Baixing_ConsumptionAuthorityWidget extends StatelessWidget {
  final Baixing_ConsumptionEntity mBaixing_entity;

  const Baixing_ConsumptionAuthorityWidget({
    Key? key,
    required this.mBaixing_entity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: mBaixing_entity.mBaixing_callback,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Color(0xFF444444),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1.w),
        ),
        child: Row(
          children: [
            // 左侧图标
            _baixing_buildIconContainer(),
            SizedBox(width: 16.w),
            // 中间内容
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 标题
                  Text(
                    mBaixing_entity.mBaixing_consumer_name,
                    style: textTheme.titleMedium!.copyWith(
                      color: Baixing_ColorGold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  // 解锁描述
                  Text(
                    mBaixing_entity.mBaixing_info,
                    style: textTheme.labelMedium!.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(width: 6.w),
            // 右侧箭头
            Icon(Icons.arrow_forward_ios, color: Colors.white),
          ],
        ),
      ),
    );
  }

  // 构建左侧图标容器
  Widget _baixing_buildIconContainer() {
    return Container(
      width: 50.w,
      height: 50.w,
      decoration: Baixing_BackGround.baixing_getRoundedRectangularOutLine(
        radius: 50.r,
        borderColor: Baixing_ColorGold,
      ),
      child: Center(
        child: Icon(mBaixing_entity.mBaixing_icon, color: Baixing_ColorGold),
      ),
    );
  }
}
