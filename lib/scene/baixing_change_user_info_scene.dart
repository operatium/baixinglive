import 'package:baixinglive/api/baixing_api.dart';

import '../api/baixing_api_thirdapi.dart';
import '../api/baixing_api_flutter.dart';

class Baixing_ChangeUserInfoScene extends StatefulWidget {
  @override
  _Baixing_ChangeUserInfoSceneState createState() =>
      _Baixing_ChangeUserInfoSceneState();
}

class _Baixing_ChangeUserInfoSceneState
    extends State<Baixing_ChangeUserInfoScene> {
  final _baixing_debouncer = Debouncer();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    Baixing_AccountModel model = context.watch();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("个人信息"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 10.h),
          GestureDetector(
            onTap: _obtainClickListener("头像"),
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                children: [
                  Text('头像', style: textTheme.titleSmall),
                  const Spacer(),
                  SizedBox(
                    width: 60.w,
                    height: 60.w,
                    child: ClipOval(
                      child: Baixing_CoverWidget(
                        mBaixing_url: model.baixing_getAvatar(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ),
          SizedBox(height: 10.h),
          _baixing_buildItem(
            title: '昵称',
            value: () => model.baixing_getNickName(),
          ),
          SizedBox(height: 1.h),
          _baixing_buildItem(
            title: '性别',
            value: () => model.baixing_getGender(),
          ),
          SizedBox(height: 1.h),
          _baixing_buildItem(
            title: '星座',
            value: () => model.baixing_getConstellation(),
          ),
          SizedBox(height: 1.h),
          _baixing_buildItem(
            title: '城市',
            value: () => model.baixing_getCity(),
          ),
          SizedBox(height: 1.h),
          _baixing_buildItem(
            title: '生日',
            value: () => model.baixing_getBirthday(),
          ),
        ],
      ),
    );
  }

  Widget _baixing_buildItem({
    required String title,
    required String Function() value,
  }) {
    return GestureDetector(
      onTap: _obtainClickListener(title),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Row(
          children: [
            Text(title, style: Theme.of(context).textTheme.titleSmall),
            const Spacer(),
            Text(value(), style: Theme.of(context).textTheme.bodySmall),
            SizedBox(width: 10.w),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }

  VoidCallback _obtainClickListener(String event) {
    ontap() {
      switch (event) {
        case "头像":
          break;
        case "昵称":
          break;
        case "性别":
          break;
        case "星座":
          break;
        case "城市":
          break;
        case "生日":
          break;
        default:
          Baixing_Toast.show(event);
          break;
      }
    }

    return () {
      _baixing_debouncer.debounce(
        duration: Baixing_dd500ms,
        onDebounce: () {
          ontap.call();
        },
      );
    };
  }
}
