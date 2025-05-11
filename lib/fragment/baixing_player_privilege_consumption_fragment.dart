import 'package:baixinglive/provider/baixing_level.dart';
import 'package:baixinglive/widget/Baixing_consumption_authority_widget.dart';
import 'package:baixinglive/widget/baixing_tag_card_widget.dart';

import '../api/baixing_api_flutter.dart';
import '../api/baixing_api_thirdapi.dart';
import '../api/baixing_api.dart';

/**
 * @author yuyuexing
 * @date: 2025-05-11
 * @description: 玩家特权消费界面
 */
class Baixing_PlayerPrivilegeConsumptionFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Baixing_PlayerPrivilegeConsumptionFragmentState();
  }
}

class _Baixing_PlayerPrivilegeConsumptionFragmentState
    extends State<Baixing_PlayerPrivilegeConsumptionFragment> {
  final List<Map<String, dynamic>> _privilegeList = [
    {
      "title": "财富称号",
      "icon": Icons.money,
      "content": "距离解锁 二富 称号，还需消费 1,600 柠檬",
    },
    {"title": "闪耀财星", "icon": Icons.star, "content": "最近 7天 消费 0 柠檬"},
    {
      "title": "私聊上限",
      "icon": Icons.messenger_rounded,
      "content": "累计消费达到 50,000柠檬 可解锁无限制私聊",
    },
    {
      "title": "创建家族",
      "icon": Icons.fax_rounded,
      "content": "累计消费达到 300,000柠檬 可解锁创建家族权限",
    },
    {
      "title": "自定义称号",
      "icon": Icons.near_me,
      "content": "累计消费达到 5,000,000柠檬 可解锁自定义称号",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final accountModel = context.watch<Baixing_AccountModel>();
    return Container(
      color: Colors.black,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10.h),
            ClipOval(
              child: Container(
                width: 80.w,
                height: 80.w,
                child: Baixing_CoverWidget(
                  mBaixing_url: accountModel.baixing_getAvatar(),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              accountModel.baixing_getNickName(),
              style: textTheme.bodyMedium!.copyWith(color: Colors.white),
            ),
            SizedBox(height: 10.h),
            Text(
              "在99直播待了100天，累计消费3000个芒果",
              style: textTheme.bodySmall!.copyWith(color: Colors.white),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: ListView.builder(
                itemCount: _privilegeList.length,
                itemBuilder: (context, index) {
                  final item = _privilegeList[index];
                  Baixing_ConsumptionEntity entity = Baixing_ConsumptionEntity(
                    mBaixing_consumer_name: item["title"],
                    mBaixing_info: item["content"],
                    mBaixing_icon: item["icon"],
                    mBaixing_callback: () {
                      baixing_showUrlDialog(context, "https://www.163.com");
                    },
                  );
                  return Baixing_ConsumptionAuthorityWidget(
                    mBaixing_entity: entity,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
