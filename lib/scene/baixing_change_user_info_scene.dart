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

  // 使用相机拍照
  Future<void> _baixing_pickImageFromCamera() async {
    // 请求相机权限
    var status = await Permission.camera.request();
    if (status.isGranted) {
      // 这里模拟拍照，实际项目中应使用image_picker等插件
      // 生成随机头像URL

      // _baixing_updateAvatar(newAvatarUrl);
    } else {
      Baixing_Toast.show('需要相机权限才能拍照');
    }
  }

  // 更新头像
  void _baixing_updateAvatar(String newAvatarUrl) {
    Baixing_AccountModel model = context.read();
    if (model.baixing_current_account != null) {
      // 创建新的账户实体并更新头像
      Baixing_AccountEntity updatedAccount = Baixing_AccountEntity(
        username: model.baixing_current_account!.username,
        password: model.baixing_current_account!.password,
        phone: model.baixing_current_account!.phone,
        token: model.baixing_current_account!.token,
        mBaixing_nickName: model.baixing_current_account!.mBaixing_nickName,
        mBaixing_id: model.baixing_current_account!.mBaixing_id,
        mBaixing_avatarUrl: newAvatarUrl,
        // 更新头像URL
        mBaixing_level: model.baixing_current_account!.mBaixing_level,
        mBaixing_levelTimeoutHit:
            model.baixing_current_account!.mBaixing_levelTimeoutHit,
        mBaixing_levelUpdateHit:
            model.baixing_current_account!.mBaixing_levelUpdateHit,
        mBaixing_gender: model.baixing_current_account!.mBaixing_gender,
        mBaixing_constellation:
            model.baixing_current_account!.mBaixing_constellation,
        mBaixing_city: model.baixing_current_account!.mBaixing_city,
        mBaixing_birthday: model.baixing_current_account!.mBaixing_birthday,
      );

      // 更新当前账户
      model.baixing_updateCurrentAccount(updatedAccount);
      Baixing_Toast.show('头像更新成功');
    }
  }

  VoidCallback _obtainClickListener(String event) {
    ontap() {
      switch (event) {
        case "头像":
          baixing_selectPictureDialog(context, (Widget image) {
            print("yyx- image: $image");
            setState(() {
              mBaixing_avtar = image;
            });
          });
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
