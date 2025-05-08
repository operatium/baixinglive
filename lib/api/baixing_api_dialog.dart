import 'package:baixinglive/api/baixing_api.dart';
import 'package:baixinglive/compat/baixing_persistence.dart';
import 'package:baixinglive/dialog/baixing_continue_teenager_mode_dialog.dart';
import 'package:baixinglive/dialog/baixing_exit_teenager_mode_dialog.dart';
import 'package:baixinglive/dialog/baixing_message_dialog.dart';
import 'package:baixinglive/dialog/baixing_privacy_agreement_dialog.dart';
import 'package:baixinglive/dialog/baixing_set_enter_teenager_mode_password_dialog.dart';
import 'package:baixinglive/dialog/baixing_teenager_mode_hit_dialog.dart';
import 'package:permission_handler/permission_handler.dart';



const bool mBaixing_debug = true;

// 显示青少年模式提示弹窗
void baixing_showTeenagersHitDialog(BuildContext context) {
  var isHide = Baixing_SharedPreferences.baixing_getBool(KEY_teenager_mode_enable);
  var showTime = Baixing_SharedPreferences.baixing_getInt(KEY_teenager_mode_dialog_time);
  final t = DateTime.now().millisecondsSinceEpoch - showTime;
  if (!isHide || t > 24 * 3600 * 1000 || mBaixing_debug) {
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
  await Baixing_SharedPreferences.init();
  var camera = await Permission.camera.isGranted;
  var storage = await Permission.storage.isGranted;
  var microphone = await Permission.microphone.isGranted;
  if (camera && storage && microphone) {
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
                Navigator.of(context).pop();
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
