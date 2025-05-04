import 'package:baixinglive/provider/baixing_account_model.dart';
import 'package:baixinglive/provider/baixing_level.dart';
import 'package:baixinglive/widget/baixing_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Baixing_UserLevelCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<Baixing_AccountModel>();
    final level = Baixing_Level.baixing_fromLevel(model.baixing_getUserLevel());
    final levelName = level.mBaixing_name;
    final levelImage = level.mBaixing_imageRes;
    final levelTimeout = model.baixing_getLevelTimeout();
    final levelupdateHit = model.baixing_getLevelUpdateHit();

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: 120.w,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFDFA275), Color(0xFFECD1BC), Color(0xFFCE875B)],
              stops: [0.0, 0.5, 1.0],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(60),
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          padding: EdgeInsets.only(left: 16, top: 12, bottom: 12, right: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: constraints.maxWidth * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 会员等级
                    Text(
                      levelName,
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    // 会员描述
                    Text(
                      levelupdateHit,
                      maxLines: 2,
                      style: TextStyle(color: Color(0xFF333333), fontSize: 10),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    // 会员进度条
                    LinearProgressIndicator(
                      value: 0.6,
                      backgroundColor: Color(0xfff7f7f7),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFF684122),
                      ),
                    ),
                    SizedBox(height: 8),
                    // 会员到期时间
                    Text(
                      '会员身份${levelTimeout}将重新结算',
                      style: TextStyle(color: Color(0xFF666666), fontSize: 10),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              // 会员徽章图标
              Expanded(
                child: Container(
                  child: Baixing_IconWidget(
                    mBaixing_url: levelImage,
                    mBaixing_imageSourceType: ImageSourceType.local,
                    mBaixing_boxFit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
