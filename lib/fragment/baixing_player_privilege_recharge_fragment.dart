import 'package:baixinglive/provider/baixing_level.dart';
import 'package:baixinglive/widget/baixing_tag_card_widget.dart';

import '../api/baixing_api_flutter.dart';
import '../api/baixing_api_thirdapi.dart';
import '../api/baixing_api.dart';

/**
* @author yuyuexing
* @date: 2025-05-11
* @description: 玩家特权充值界面
*/
class Baixing_PlayerPrivilegeRechargeFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Baixing_PlayerPrivilegeRechargeFragmentState();
  }
}

class _Baixing_PlayerPrivilegeRechargeFragmentState extends State<Baixing_PlayerPrivilegeRechargeFragment> {

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final accountModel = context.watch<Baixing_AccountModel>();
    final level = Baixing_Level.baixing_fromLevel(accountModel.baixing_getUserLevel());
    return Container(
      color: Colors.black,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 青铜特权卡片
              Baixing_UserLevelCardWidget(),
              SizedBox(height: 16.h),
              _baixing_rules(context),
              SizedBox(height: 16.h),
              Baixing_TagCardWidget(
                  mbaixing_card_name: level.mBaixing_name,
                  mbaixing_is_lock: true,
                  mbaixing_user_flags: [
                    Baixing_UserFlagEntity(
                        mBaixing_flagName: "等级标志",
                        mBaixing_isLock: false,
                        mBaixing_icon: Icons.person,
                    ),
                    Baixing_UserFlagEntity(
                      mBaixing_flagName: "升级通知",
                      mBaixing_isLock: true,
                      mBaixing_icon: Icons.upload_sharp,
                    ),
                    Baixing_UserFlagEntity(
                      mBaixing_flagName: "进房消息提醒",
                      mBaixing_isLock: true,
                      mBaixing_icon: Icons.message_sharp,
                    ),
                  ],
              ),
              SizedBox(height: 16.h),
              Baixing_TagCardWidget(
                mbaixing_card_name: "基础权益",
                mbaixing_is_lock: false,
                mbaixing_user_flags: [
                  Baixing_UserFlagEntity(
                    mBaixing_flagName: "等级标志",
                    mBaixing_isLock: false,
                    mBaixing_icon: Icons.person,
                  ),
                  Baixing_UserFlagEntity(
                    mBaixing_flagName: "升级通知",
                    mBaixing_isLock: true,
                    mBaixing_icon: Icons.upload_sharp,
                  ),
                  Baixing_UserFlagEntity(
                    mBaixing_flagName: "升级动效",
                    mBaixing_isLock: true,
                    mBaixing_icon: Icons.animation,
                  ),
                  Baixing_UserFlagEntity(
                    mBaixing_flagName: "进房消息提醒",
                    mBaixing_isLock: true,
                    mBaixing_icon: Icons.message_sharp,
                  ),
                  Baixing_UserFlagEntity(
                    mBaixing_flagName: "专属入场气泡",
                    mBaixing_isLock: true,
                    mBaixing_icon: Icons.messenger_outline,
                  ),
                  Baixing_UserFlagEntity(
                    mBaixing_flagName: "专属表情包",
                    mBaixing_isLock: true,
                    mBaixing_icon: Icons.face,
                  ),
                  Baixing_UserFlagEntity(
                    mBaixing_flagName: "专属礼物",
                    mBaixing_isLock: true,
                    mBaixing_icon: Icons.card_giftcard,
                  ),
                  Baixing_UserFlagEntity(
                    mBaixing_flagName: "热度特权",
                    mBaixing_isLock: true,
                    mBaixing_icon: Icons.hotel_class_outlined,
                  ),
                  Baixing_UserFlagEntity(
                    mBaixing_flagName: "直播间贵宾区",
                    mBaixing_isLock: true,
                    mBaixing_icon: Icons.layers,
                  ),
                  Baixing_UserFlagEntity(
                    mBaixing_flagName: "防踢防禁言",
                    mBaixing_isLock: true,
                    mBaixing_icon: Icons.eject_outlined,
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Baixing_TagCardWidget(
                mbaixing_card_name: "福利礼包",
                mbaixing_is_lock: false,
                mbaixing_user_flags: [
                  Baixing_UserFlagEntity(
                    mBaixing_flagName: "充值福利",
                    mBaixing_isLock: false,
                    mBaixing_icon: Icons.monetization_on_outlined,
                  ),
                  Baixing_UserFlagEntity(
                    mBaixing_flagName: "保级福利",
                    mBaixing_isLock: true,
                    mBaixing_icon: Icons.join_left_outlined,
                  ),
                  Baixing_UserFlagEntity(
                    mBaixing_flagName: "回归福利",
                    mBaixing_isLock: true,
                    mBaixing_icon: Icons.bakery_dining_rounded,
                  ),
                  Baixing_UserFlagEntity(
                    mBaixing_flagName: "节日福利",
                    mBaixing_isLock: true,
                    mBaixing_icon: Icons.healing,
                  ),
                  Baixing_UserFlagEntity(
                    mBaixing_flagName: "免费月卡福利",
                    mBaixing_isLock: true,
                    mBaixing_icon: Icons.calendar_month,
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Baixing_TagCardWidget(
                mbaixing_card_name: "主播服务",
                mbaixing_is_lock: false,
                mbaixing_user_flags: [
                  Baixing_UserFlagEntity(
                    mBaixing_flagName: "主播服务评选",
                    mBaixing_isLock: false,
                    mBaixing_icon: Icons.mail,
                  ),
                  Baixing_UserFlagEntity(
                    mBaixing_flagName: "主播荣耀粉丝",
                    mBaixing_isLock: true,
                    mBaixing_icon: Icons.fire_extinguisher,
                  ),
                  Baixing_UserFlagEntity(
                    mBaixing_flagName: "新晋主播资讯",
                    mBaixing_isLock: true,
                    mBaixing_icon: Icons.dataset_linked,
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Baixing_TagCardWidget(
                mbaixing_card_name: "个性化",
                mbaixing_is_lock: false,
                mbaixing_user_flags: [
                  Baixing_UserFlagEntity(
                    mBaixing_flagName: "开启神行百变",
                    mBaixing_isLock: false,
                    mBaixing_icon: Icons.brightness_auto,
                  ),
                  Baixing_UserFlagEntity(
                    mBaixing_flagName: "限免装扮",
                    mBaixing_isLock: true,
                    mBaixing_icon: Icons.facebook_outlined,
                  ),
                  Baixing_UserFlagEntity(
                    mBaixing_flagName: "装扮特惠",
                    mBaixing_isLock: true,
                    mBaixing_icon: Icons.favorite_border,
                  ),
                  Baixing_UserFlagEntity(
                    mBaixing_flagName: "炫彩昵称特惠",
                    mBaixing_isLock: true,
                    mBaixing_icon: Icons.nightlife_rounded,
                  ),
                  Baixing_UserFlagEntity(
                    mBaixing_flagName: "极品靓号",
                    mBaixing_isLock: true,
                    mBaixing_icon: Icons.phone_forwarded_rounded,
                  ),
                  Baixing_UserFlagEntity(
                    mBaixing_flagName: "神行百变特惠",
                    mBaixing_isLock: true,
                    mBaixing_icon: Icons.nordic_walking_outlined,
                  ),
                  Baixing_UserFlagEntity(
                    mBaixing_flagName: "APP主题皮肤",
                    mBaixing_isLock: true,
                    mBaixing_icon: Icons.apps_outage_outlined,
                  ),
                ],
              ),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _baixing_rules(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Text(
          '升级解锁新特权',
          style: textTheme.titleMedium!.copyWith(color: Color(0xFFFFD97A)),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            GoRouter.of(context).push('/localWeb', extra: [
              "等级规则",
              """
            <html style="background:#000;">
            <head>
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
            </head>
            <body style="margin:0;padding:0;background:#000;display:flex;align-items:center;justify-content:center;height:100vh;">
                <img src="file:///android_asset/baixing_rule.jpg" style="width:100%;display:block;margin:auto;"/>
            </body>
            </html>
        """
            ]);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Text(
              '等级规则 >',
              style: textTheme.titleMedium!.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 升级特权卡片
  Widget _baixing_buildUpgradePrivilegeCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Color(0xFF333333),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '升级特权解锁特权',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _baixing_buildUpgradeItem(Icons.card_giftcard, '专属礼物'),
              _baixing_buildUpgradeItem(Icons.star, '徽章特效'),
              _baixing_buildUpgradeItem(Icons.volume_up, '弹幕特效'),
            ],
          ),
          SizedBox(height: 8.h),
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Color(0xFFFFD97A),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                '立即升级',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 升级项目
  Widget _baixing_buildUpgradeItem(IconData icon, String text) {
    return Column(
      children: [
        Container(
          width: 50.w,
          height: 50.h,
          decoration: BoxDecoration(
            color: Color(0xFF444444),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Color(0xFFFFD97A), size: 24.sp),
        ),
        SizedBox(height: 8.h),
        Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 12.sp),
        ),
      ],
    );
  }

  // 全部等级特权标题
  Widget _baixing_buildAllPrivilegesTitle() {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Text(
        '《 全部等级特权 》',
        style: TextStyle(
          color: Color(0xFFFFD97A),
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // 特权分区
  Widget _baixing_buildPrivilegeSection(String title, List<Map<String, dynamic>> privileges) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Color(0xFF222222),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 0.8,
              crossAxisSpacing: 8.w,
              mainAxisSpacing: 16.h,
            ),
            itemCount: privileges.length,
            itemBuilder: (context, index) {
              return _baixing_buildPrivilegeItem(
                privileges[index]['icon'],
                privileges[index]['name'],
                privileges[index]['level'],
              );
            },
          ),
        ],
      ),
    );
  }

  // 特权项目
  Widget _baixing_buildPrivilegeItem(IconData icon, String name, String level) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 50.w,
              height: 50.h,
              decoration: BoxDecoration(
                color: Color(0xFF333333),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 24.sp),
            ),
            if (level.isNotEmpty)
              Positioned(
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFD97A),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    level,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          name,
          style: TextStyle(color: Colors.white, fontSize: 12.sp),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  // 基础特权数据
  List<Map<String, dynamic>> _baixing_getBasicPrivileges() {
    return [
      {'icon': Icons.videocam, 'name': '专属标识', 'level': '青铜1'},
      {'icon': Icons.volume_up, 'name': '弹幕特效', 'level': '青铜3'},
      {'icon': Icons.notifications, 'name': '消息提醒', 'level': '青铜5'},
      {'icon': Icons.lock, 'name': '开通隐身', 'level': '白银1'},
    ];
  }

  // 福利礼包数据
  List<Map<String, dynamic>> _baixing_getWelfarePrivileges() {
    return [
      {'icon': Icons.card_giftcard, 'name': '生日礼包', 'level': '青铜2'},
      {'icon': Icons.star, 'name': '每月礼包', 'level': '青铜4'},
      {'icon': Icons.redeem, 'name': '节日礼包', 'level': '白银2'},
      {'icon': Icons.local_activity, 'name': '全场礼物半价', 'level': '黄金1'},
    ];
  }

  // 主播服务数据
  List<Map<String, dynamic>> _baixing_getAnchorServices() {
    return [
      {'icon': Icons.person, 'name': '主播陪玩', 'level': '白银3'},
      {'icon': Icons.mic, 'name': '主播点歌', 'level': '白银5'},
      {'icon': Icons.video_call, 'name': '单独主播', 'level': '黄金3'},
    ];
  }

  // 个性化数据
  List<Map<String, dynamic>> _baixing_getPersonalizedPrivileges() {
    return [
      {'icon': Icons.mail, 'name': '私信解锁', 'level': '青铜5'},
      {'icon': Icons.photo_camera, 'name': '照片墙', 'level': '白银2'},
      {'icon': Icons.emoji_emotions, 'name': '表情解锁', 'level': '白银4'},
      {'icon': Icons.color_lens, 'name': '炫彩昵称', 'level': '黄金2'},
      {'icon': Icons.star_border, 'name': '个性装扮', 'level': '黄金5'},
      {'icon': Icons.public, 'name': '全站推广', 'level': '铂金3'},
      {'icon': Icons.app_registration, 'name': 'APP主题', 'level': '钻石1'},
    ];
  }


}