import 'package:baixinglive/compat/baixing_persistence.dart';
import 'package:baixinglive/provider/baixing_account_model.dart';
import 'package:baixinglive/api/baixing_api.dart';

class Baixing_SplashScene extends StatefulWidget {
  const Baixing_SplashScene({super.key});

  @override
  State<Baixing_SplashScene> createState() => _Baixing_SplashSceneState();
}

class _Baixing_SplashSceneState extends State<Baixing_SplashScene> {
  String _TAG = "yyx _Baixing_SplashSceneState: ";

  _Baixing_SplashSceneState() {
    print(_TAG + 'State 构造函数被调用');
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final isEnabled = await _baixing_checkTeenagerMode(context);
      if (isEnabled) {
        baixing_requestPermissionDialog(context: context, nextDo: _goNextScene);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print(_TAG + 'didChangeDependencies 方法被调用');
  }

  @override
  void didUpdateWidget(covariant Baixing_SplashScene oldWidget) {
    super.didUpdateWidget(oldWidget);
    print(_TAG + 'didUpdateWidget 方法被调用');
  }

  @override
  void deactivate() {
    super.deactivate();
    print(_TAG + 'deactivate 方法被调用');
  }

  @override
  void dispose() {
    print(_TAG + 'dispose 方法被调用');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(_TAG + 'build 方法被调用');
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/baixing_bg_jianbian.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                width: 80.w,
                height: 82.w,
                child: Image.asset("images/baixing_logo.webp"),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: IntrinsicHeight(
                child: Container(
                  margin: EdgeInsets.only(bottom: 20.w),
                  child: Column(
                    children: [
                      Container(
                        width: 77.w,
                        height: 20.w,
                        margin: EdgeInsets.only(bottom: 5.w),
                        child: Image.asset("images/baixing_99zhibo_text.webp"),
                      ),
                      Text(
                        "与喜欢的你不期而遇",
                        style: TextStyle(
                          color: Color(0xFF999999),
                          fontSize: 8.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  FutureOr<void> _goNextScene() async {
    final model = context.read<Baixing_AccountModel>();
    await model.resume();
    if (model.baixing_current_account != null) {
      GoRouter.of(context).go("/home");
      return;
    }
    GoRouter.of(context).go("/selectLogin");
  }

  Future<bool> _baixing_checkTeenagerMode(BuildContext context) async {
    await Baixing_SharedPreferences.init();
    final isEnabled =
      await Baixing_SharedPreferences.baixing_getBool(KEY_teenager_mode_enable);
    if (isEnabled) {
      // 检查当前时间是否在允许使用的时间范围内（6:00-22:00）
      final now = DateTime.now();
      final hour = now.hour;
      if (hour >= 22 || hour < 6) {
        // 在禁止使用时间段内
        baixing_showTeenagerModeTimeoutDialog(context);
        exit(0);
      } else {
        // 跳转到青少年模式内容页面
        delay500(() => GoRouter.of(context).go("/teenagerContent"));
      }
      return false;
    }
    return true;
  }
}