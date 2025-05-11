import 'package:baixinglive/api/baixing_api.dart';
import 'package:baixinglive/api/baixing_api_thirdapi.dart';

import '../api/baixing_api_flutter.dart';

class Baixing_TagCardWidget extends StatelessWidget {
  final String mbaixing_card_name;
  final bool mbaixing_is_lock;
  final String mbaixing_sub_title;
  final List<Baixing_UserFlagEntity> mbaixing_user_flags;
  int mBaixing_itemRowCount = 4;

  Baixing_TagCardWidget({
    super.key,
    required this.mbaixing_card_name,
    required this.mbaixing_is_lock,
    this.mbaixing_sub_title = "",
    required this.mbaixing_user_flags,
    this.mBaixing_itemRowCount = 4,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    if (mbaixing_user_flags.length < mBaixing_itemRowCount) {
      mBaixing_itemRowCount = mbaixing_user_flags.length;
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        color: Color(0xFF1B1B1B),
        padding: EdgeInsets.only(bottom: 10.w),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
              decoration: Baixing_BackGround.baixing_getRectangularGradient(
                startColor:  Color(0xFF41403C),
                endColor: Color(0xFF232323),
              ),
              child: Row(
                children: [
                  mbaixing_is_lock
                      ? Icon(Icons.lock, color: Color(0xFFF4C581))
                      : SizedBox.shrink(),
                  SizedBox(width: 4.w),
                  Text(
                    mbaixing_card_name,
                    style: textTheme.titleMedium!.copyWith(
                      color: Color(0xFFF4C581),
                    ),
                  ),
                  const Spacer(),
                  mbaixing_sub_title.isNotEmpty
                      ? Text(
                    mbaixing_sub_title,
                    style: textTheme.titleMedium!.copyWith(
                      color: Color(0xFFF4C581),
                    ),
                  )
                      : SizedBox.shrink(),
                  SizedBox(width: 10.w),
                ],
              ),
            ),
            SizedBox(height: 10.w),
            LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final itemWidthSpacing = (width - (80.w * mBaixing_itemRowCount)) / (mBaixing_itemRowCount + 1);
                return Wrap(
                  spacing: itemWidthSpacing,
                  runSpacing: 10.w,
                  children:
                  mbaixing_user_flags
                      .map(
                        (e) =>
                        GestureDetector(
                          onTap: () {
                            baixing_showUrlDialog(context, e.mBaixing_url);
                          },
                          child: Baixing_TagWidget(
                            mBaixing_icon: e.mBaixing_icon,
                            mBaixing_tag_name: e.mBaixing_flagName,
                            mBaixing_is_lock: e.mBaixing_isLock,
                          ),
                        ),
                  )
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
