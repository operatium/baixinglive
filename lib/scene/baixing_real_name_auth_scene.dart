
import '../api/baixing_api.dart';
import '../api/baixing_api_flutter.dart';
import '../api/baixing_api_thirdapi.dart';

/**
 * @author yuyuexing
 * @date: 2025-05-08
 * @description: 实名认证界面，用于用户提交真实姓名和身份证号进行实名认证
 */

class Baixing_RealNameAuthScene extends StatefulWidget {
  const Baixing_RealNameAuthScene({super.key});

  @override
  State<Baixing_RealNameAuthScene> createState() =>
      _Baixing_RealNameAuthSceneState();
}

class _Baixing_RealNameAuthSceneState extends State<Baixing_RealNameAuthScene>
    with SingleTickerProviderStateMixin {
  final TextEditingController _mBaixing_nameController =
      TextEditingController();
  final TextEditingController _mBaixing_idCardController =
      TextEditingController();
  bool _mBaixing_isAgree = false;

  // 添加动画控制器和动画
  late AnimationController _mBaixing_animationController;
  late Animation<double> _mBaixing_animation;
  int _mBaixing_animationCount = 5; // 控制抖动次数
  final Debouncer _mBaixing_debouncer = Debouncer();

  @override
  void initState() {
    super.initState();

    // 初始化动画控制器
    _mBaixing_animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _mBaixing_animationController.reverse();
      }
      if (status == AnimationStatus.dismissed) {
        if (_mBaixing_animationCount > 0) {
          _mBaixing_animationController.forward();
        }
      }
      _mBaixing_animationCount--;
    });

    // 定义抖动动画
    _mBaixing_animation = Tween(
      begin: 0.0,
      end: 10.0,
    ).animate(_mBaixing_animationController);
  }

  @override
  void dispose() {
    _mBaixing_nameController.dispose();
    _mBaixing_idCardController.dispose();
    _mBaixing_animationController.dispose();
    super.dispose();
  }

  void _baixing_submitAuth() {
    if (_mBaixing_nameController.text.isEmpty) {
      Baixing_Toast.show("请输入真实姓名");
      return;
    }
    if (_mBaixing_idCardController.text.isEmpty) {
      Baixing_Toast.show("请输入身份证号");
      return;
    }
    if (!_mBaixing_isAgree) {
      Baixing_Toast.show("请阅读并同意主播管理协议");
      _mBaixing_animationCount = 5;
      _mBaixing_animationController.forward();
      Baixing_Vibrate.vibrate();
      return;
    }

    // 提交实名认证信息
    Baixing_Toast.show("实名认证提交成功");
    // 返回上一页
    Navigator.of(context).pop();
    GoRouter.of(context).push("/setAuthorPhone");
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text("实名认证"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Text(
                  "根据相关法规，使用部分服务前需完成身份认证：\n认证信息将用于开直播、收益提现等，与账号绑定，我们会对信息进行严格保密",
                  style: textTheme.labelMedium,
                ),
                SizedBox(height: 20.h),
                Text("真实姓名", style: textTheme.titleSmall),
                SizedBox(height: 10.h),
                CupertinoTextField(
                  style: TextStyle(fontSize: 14.sp),
                  placeholder: "请输入真实姓名",
                  controller: _mBaixing_nameController,
                ),
                SizedBox(height: 20.h),
                Text("身份证号", style: textTheme.titleSmall),
                SizedBox(height: 10.h),
                CupertinoTextField(
                  maxLength: 18,
                  style: TextStyle(fontSize: 14.sp),
                  placeholder: "请输入身份证号",
                  controller: _mBaixing_idCardController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(18),
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9Xx]')),
                  ],
                ),
                SizedBox(height: 20.h),
                AnimatedBuilder(
                  animation: _mBaixing_animation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(_mBaixing_animation.value, 0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 24.w,
                            height: 24.w,
                            child: Checkbox(
                              value: _mBaixing_isAgree,
                              onChanged: (value) {
                                setState(() {
                                  _mBaixing_isAgree = value ?? false;
                                });
                              },
                              activeColor: Color(0xFF7654F2),
                            ),
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            "我已阅读并同意",
                            style: textTheme.labelSmall!.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              GoRouter.of(
                                context,
                              ).push("/web?url=https://www.163.com");
                            },
                            child: Text(
                              "《主播管理协议》",
                              style: textTheme.labelSmall!.copyWith(
                                color: Color(0xff3F8CFF),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: 30.h),
                GestureDetector(
                  onTap: () {
                    _mBaixing_debouncer.debounce(
                      duration: Baixing_dd500ms,
                      onDebounce: _baixing_submitAuth,
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    decoration:
                        Baixing_BackGround.baixing_getRoundedRectangular_K002(),
                    child: Center(
                      child: Text(
                        "同意协议并认证",
                        style: textTheme.titleSmall!.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
