
import '../api/baixing_api.dart';
import '../api/baixing_api_flutter.dart';
import '../api/baixing_api_thirdapi.dart';

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
    final model = context.watch<Baixing_AccountModel>();
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            _baixing_getTopLayout(context),
            Baixing_UserBaseInfo(),
            Baixing_UserLevelCardWidget(),
            _baixing_walletLayout(context, model),
            Container(
              decoration: Baixing_BackGround.baixing_getRoundedRectangular(
                radius: 16.w,
              ),
              padding: EdgeInsets.all(16.w),
              margin: EdgeInsets.only(top: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _getButton(event: "装扮", icon: "images/baixing_99.webp"),
                  _getButton(event: "神行百变", icon: "images/baixing_99.webp"),
                  _getButton(event: "靓号", icon: "images/baixing_99.webp"),
                  _getButton(event: "炫彩昵称", icon: "images/baixing_99.webp"),
                ],
              ),
            ),
            Container(
              decoration: Baixing_BackGround.baixing_getRoundedRectangular(
                radius: 16.w,
              ),
              padding: EdgeInsets.all(16.w),
              margin: EdgeInsets.only(top: 16.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _getButton(event: "我看过的", icon: "images/baixing_99.webp"),
                      _getButton(event: "99家族", icon: "images/baixing_99.webp"),
                      _getButton(
                        event: "公会长申请",
                        icon: "images/baixing_99.webp",
                      ),
                      _getButton(event: "联系客服", icon: "images/baixing_99.webp"),
                    ],
                  ),
                  SizedBox.fromSize(size: const Size(0, 16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _getButton(event: "帮助说明", icon: "images/baixing_99.webp"),
                      _getButton(event: "99公益", icon: "images/baixing_99.webp"),
                      _getButton(event: "礼品卡", icon: "images/baixing_99.webp"),
                      _getButton(event: "平台公告", icon: "images/baixing_99.webp"),
                    ],
                  ),
                  SizedBox.fromSize(size: const Size(0, 16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _getButton(event: "版权投诉", icon: "images/baixing_99.webp"),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox.fromSize(size: const Size(0, 16)),
          ],
        ),
      ),
    );
  }

  Widget _baixing_getTopLayout(BuildContext context) {
    return Row(
      children: [
        _getButton(event: "我要开播"),
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

  Widget _baixing_walletLayout(
    BuildContext context,
    Baixing_AccountModel model,
  ) {
    return Container(
      margin: EdgeInsets.only(top: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: Baixing_BackGround.baixing_getRoundedRectangular(
        radius: 16.w,
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('我的钱包', style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: 8.w),
              Row(
                children: [
                  Image.asset(
                    'images/baixing_99.webp',
                    width: 24.w,
                    height: 24.w,
                  ),
                  SizedBox(width: 4),
                  Text('1,700', style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
            ],
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: _getButton(event: "充值"),
          ),
        ],
      ),
    );
  }

  Widget _getButton({required String event, String icon = ""}) {
    Widget? view;
    if (event == "我要开播") {
      view = Container(
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
      );
    }
    if (event == "充值") {
      view = Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.w),
        decoration: Baixing_BackGround.baixing_getRoundedRectangular(
          radius: 15.w,
          color: Colors.deepPurpleAccent,
        ),
        child: Text(
          '充值',
          style: TextTheme.of(
            context,
          ).titleMedium!.copyWith(color: Colors.white),
        ),
      );
    }
    view ??= Container(
      width: 63.w,
      child: Column(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            margin: EdgeInsets.only(bottom: 8.w),
            child: ClipOval(
              child: Baixing_IconWidget(
                mBaixing_url: icon,
                mBaixing_imageSourceType: ImageSourceType.local,
              ),
            ),
          ),
          Text(event, style: Theme.of(context).textTheme.titleSmall),
        ],
      ),
    );
    return GestureDetector(onTap: _obtainClick(event), child: view);
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
    if (event == "充值") {
      return () {
        Baixing_Toast.show("充值");
      };
    }
    if (event == "装扮") {
      return () {
        Baixing_Toast.show("装扮");
      };
    }
    if (event == "神行百变") {
      return () {
        Baixing_Toast.show("神行百变");
      };
    }
    if (event == "靓号") {
      return () {
        Baixing_Toast.show("靓号");
      };
    }
    if (event == "炫彩昵称") {
      return () {
        Baixing_Toast.show("炫彩昵称");
      };
    }
    if (event == "装扮") {
      return () {
        Baixing_Toast.show("装扮");
      };
    }
    return null;
  }
}
