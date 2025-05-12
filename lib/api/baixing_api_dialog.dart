import 'package:baixinglive/api/baixing_api.dart';
import 'package:baixinglive/scene/baixing_login_scene.dart';
import 'package:baixinglive/scene/baixing_web_scene.dart';

import '../dialog/baixing_select_birthday_dialog.dart';
import '../dialog/baixing_select_city_dialog.dart';
import '../dialog/baixing_select_constellation_dialog.dart';
import '../dialog/baixing_select_gender_dialog.dart';
import '../dialog/baixing_take_picture_dialog.dart';
import '../dialog/baixing_continue_teenager_mode_dialog.dart';
import '../dialog/baixing_exit_teenager_mode_dialog.dart';
import '../dialog/baixing_message_dialog.dart';
import '../dialog/baixing_privacy_agreement_dialog.dart';
import '../dialog/baixing_recharge_confirm_dialog.dart';
import '../dialog/baixing_set_enter_teenager_mode_password_dialog.dart';
import '../dialog/baixing_teenager_mode_hit_dialog.dart';

import 'baixing_api_flutter.dart';
import 'baixing_api_thirdapi.dart';
import 'baixing_api_provider.dart';
import 'baixing_api_config.dart';

// 显示青少年模式提示弹窗
void baixing_showTeenagersHitDialog(BuildContext context) {
  Baixing_TeenagerModeModel model = context.read();
  if ((!model.baixing_enable && model.baixing_shouldShowEnterDialog()) ||
      mBaixing_debug) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder:
          (context) => Dialog(child: const Baixing_TeenagerModeHitDialog()),
    );
  }
}

// 设置青少年模式密码
void baixing_showSetTeenagerModePasswordDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Color(0x55000000),
    builder:
        (context) =>
            Dialog(child: const Baixing_SetEnterTeenagerModePasswordDialog()),
  );
}

// 申请权限
void baixing_requestPermissionDialog({
  required BuildContext context,
  required FutureOr<void> Function() nextDo,
}) async {
  final camera = await Permission.camera.isGranted;
  final storage = await Permission.storage.isGranted;
  final microphone = await Permission.microphone.isGranted;
  final photos = await Permission.photos.isGranted;
  if (camera && storage && microphone && photos) {
    delay500(() => nextDo());
    return;
  }
  showCupertinoDialog(
    context: context,
    barrierDismissible: false,
    builder:
        (context) =>
            Baixing_PrivacyAgressmentDialog(mbaixing_goNextScene: nextDo),
  );
}

// 显示时间限制对话框
void baixing_showTeenagerModeTimeoutDialog(BuildContext context) {
  showCupertinoDialog(
    context: context,
    barrierDismissible: false,
    builder:
        (context) => CupertinoAlertDialog(
          title: Text("使用时间限制"),
          content: Text("根据青少年模式设置，当前时段（22:00-6:00）无法使用应用"),
          actions: [
            TextButton(
              onPressed: () {
                // 退出应用
                exit(0);
              },
              child: Text("我知道了"),
            ),
          ],
        ),
  );
}

// 退出青少年模式
void baixing_exitTeenagerModeDialog(
  BuildContext context,
  bool Function(String) goNextScene,
) {
  showCupertinoDialog(
    context: context,
    builder: (context) {
      return Baixing_ExitTeenagerModeDialog(mBaixing_goNextScene: goNextScene);
    },
  );
}

// 显示时间用完对话框
Baixing_MessageDialog baixing_showTeenagerModeTimeOutDialog(
  BuildContext context,
  VoidCallback inputPassword,
) {
  Baixing_MessageDialog dialog = Baixing_MessageDialog(
    mbaixing_title: "使用时间已到",
    mbaixing_message: "今日使用时间已达到上限，请输入监护密码继续使用",
    mbaixing_buttonText: "输入密码",
    mbaixing_onPressed: inputPassword,
  );
  showCupertinoDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => PopScope(canPop: false, child: dialog),
  );
  return dialog;
}

// 青少年模式继时间
void baixing_continueTeenagerModeDialog(
  BuildContext context,
  FutureOr<bool> Function(String) next,
) {
  showCupertinoDialog(
    context: context,
    builder: (context) {
      return Baixing_ContinueTeenagerModeDialog(mBaixing_nextDo: next);
    },
  );
}

// 实名对话框
void baixing_toRealNameDialog(BuildContext context, VoidCallback callback) {
  Baixing_MessageDialog dialog = Baixing_MessageDialog(
    mbaixing_title: "实名认证",
    mbaixing_message: "根据法律法规要求，在平台申请开播前需完成身份认证",
    mbaixing_buttonText: "去认证",
    mbaixing_onPressed: callback,
  );
  showCupertinoDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => dialog,
  );
}

// 公会列表弹窗
void baixing_showGuildListDialog(
  BuildContext context,
  void Function(String) callback,
) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return SizedBox(
        height: 300,
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("公会$index"),
              onTap: () {
                callback("公会$index");
                Navigator.pop(context);
              },
            );
          },
        ),
      );
    },
  );
}

// 显示选择头像的底部弹窗
void baixing_selectPictureDialog(
  BuildContext context,
  void Function(Widget) callback,
) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) {
      return Baixing_TakePictureDialog(mBaixing_callbackImage: callback);
    },
  );
}

// 显示选择性别的底部弹窗
void baixing_selectGenderDialog(
  BuildContext context,
  void Function(String) callback,
) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) {
      return Baixing_SelectGenderDialog(mBaixing_callback: callback);
    },
  );
}

// 显示选择星座的底部弹窗
void baixing_selectConstellationDialog(
  BuildContext context,
  String constellation,
  void Function(String) callback,
) {
  showModalBottomSheet(
    context: context,
    enableDrag: false,
    builder: (context) {
      return Baixing_SelectConstellationDialog(
        initialIndex: constellation,
        onSelected: (index) {
          callback(index);
        },
      );
    },
  );
}

// 显示选择城市的底部弹窗
void baixing_selectCityDialog(
  BuildContext context,
  void Function(String, String) callback,
) {
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Baixing_SelectCityDialog(mBaixing_citySelected: callback);
    },
  );
}

// 显示选择生日的底部弹窗
Future<DateTime?> baixing_selectBirthdayDialog(BuildContext context) async {
  return showModalBottomSheet<DateTime>(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Baixing_SelectBirthdayDialog();
    },
  );
}

// 显示网页
void baixing_showUrlDialog(BuildContext context, String url) {
  showModalBottomSheet<void>(
    context: context,
    builder: (context) => Baixing_WebScene(url: url),
  );
}

// 显示充值确认对话框
void baixing_showRechargeConfirmDialog({
  required BuildContext context,
  required int amount, // 充值金额（元）
  required int lemonAmount, // 柠檬数量
  required Function(String) onConfirm, // 确认支付回调
}) {
  showModalBottomSheet(
    context: context,
    enableDrag: false,
    backgroundColor: Colors.transparent,
    builder: (context) => Baixing_RechargeConfirmDialog(
      mBaixing_amount: amount,
      mBaixing_lemonAmount: lemonAmount,
      mBaixing_onConfirm: (paymentMethod) {
        Navigator.of(context).pop();
        onConfirm(paymentMethod);
      },
    ),
  );
}

// 显示登录对话框
void baixing_showLoginDialog(BuildContext context) {
  showModalBottomSheet(
    context: context,
    enableDrag: false,
    isScrollControlled: true,
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * 0.7,
    ),
    builder: (context) => Baixing_LoginScene(mBaixing_isDialogStyle: true,),
  );
}

// 弹窗是否继续
Future<bool> baixing_isContinueDialog(
    BuildContext context,
    String title,
    String selectLeft,
    String selectRight
    ) async {
  return await showCupertinoDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text(title),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Text(
              selectLeft,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text(
              selectRight,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ],
      );
    },
  );
}
