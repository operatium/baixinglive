import 'package:baixinglive/api/baixing_api.dart';

import '../api/baixing_api_thirdapi.dart';
import '../api/baixing_api_flutter.dart';

/*
 * @Date: 2020-09-08 15:56:43
 * @Author: yuyuexing
 * @Description: 修改用户信息
 */
class Baixing_ChangeUserInfoScene extends StatefulWidget {
  @override
  _Baixing_ChangeUserInfoSceneState createState() =>
      _Baixing_ChangeUserInfoSceneState();
}

class _Baixing_ChangeUserInfoSceneState
    extends State<Baixing_ChangeUserInfoScene> {
  final _baixing_debouncer = Debouncer();
  Widget? mBaixing_avtar;

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
                  Container(
                    decoration: Baixing_BackGround.baixing_getCircle(),
                    width: 50.w,
                    height: 50.w,
                    child: ClipOval(
                      child:
                          (mBaixing_avtar == null)
                              ? Baixing_CoverWidget(
                                mBaixing_url: model.baixing_getAvatar(),
                              )
                              : mBaixing_avtar,
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
          _baixing_buildItem(title: '城市', value: () => model.baixing_getCity()),
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
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            Text(title, style: Theme.of(context).textTheme.titleSmall),
            const Spacer(),
            Text(value(), style: Theme.of(context).textTheme.bodyMedium),
            SizedBox(width: 10.w),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }

  void _message(String str) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(str)),
    );
  }

  VoidCallback _obtainClickListener(String event) {
    ontap() {
      final model = context.read<Baixing_AccountModel>();
      switch (event) {
        case "头像":
          baixing_selectPictureDialog(context, (Widget image) {
            setState(() {
              mBaixing_avtar = image;
            });
            _message("头像已保存");
          });
          break;
        case "昵称":
          GoRouter.of(context).push('/nickNameEdit');
          break;
        case "性别":
          baixing_selectGenderDialog(context, (String gender) {
            model.baixing_setGender(gender);
            _message("性别已保存");
          });
          break;
        case "星座":
          baixing_selectConstellationDialog(context,(String constellation){
            _message("$constellation已保存");
          });
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
