import 'package:baixinglive/compat/baixing_toast.dart';
import 'package:baixinglive/provider/baixing_account_model.dart';
import 'package:baixinglive/widget/baixing_background.dart';
import 'package:baixinglive/widget/baixing_cover_widget.dart';
import 'package:baixinglive/widget/baixing_icon_widget.dart';
import 'package:baixinglive/widget/baixing_user_base_info_widget.dart';
import 'package:baixinglive/widget/baixing_user_level_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Baixing_MeFragment extends StatefulWidget {
  const Baixing_MeFragment({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Baixing_MeFragmentState();
  }
}

class _Baixing_MeFragmentState extends State<Baixing_MeFragment> {
  @override
  Widget build(BuildContext context) {
    print("yyx- Baixing_MeFragment build");
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(children: [
        _baixing_getTopLayout(),
          Baixing_UserBaseInfo(),
          Baixing_UserLevelCardWidget(),
      ]),
    );
  }

  Widget _baixing_getTopLayout() {
    return Row(
      children: [
        _getButton("我要开播"),
        const Spacer(),
        GestureDetector(
          onTap: _obtainClick("设置"),
          child: Padding(
            padding: EdgeInsets.all(6.w),
            child: Icon(Icons.settings_outlined, color: Colors.black),
          ),
        ),
      ],
    );
  }

  Widget _getButton(String event) {
    if (event == "我要开播") {
      return GestureDetector(
        onTap: _obtainClick("我要开播"),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: Baixing_BackGround.baixing_getRoundedRectangularOutLine(),
          height: 25.w,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.video_call_outlined, color: Colors.black),
              SizedBox(width: 4.w),
              Text('我要开播', style: TextTheme.of(context).titleSmall),
            ],
          ),
        )
      );
    }
    return Container();
  }

  VoidCallback? _obtainClick(String event) {
    if (event == "我要开播") {
      return () {
        Baixing_Toast.show("我要开播");
      };
    }
    if (event == "设置") {
      return () {
        Baixing_Toast.show("设置");
      };
    }
    return null;
  }
}
