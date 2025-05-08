import '../api/baixing_api_flutter.dart';
import '../api/baixing_api_thirdapi.dart';
import '../api/baixing_api.dart';

/**
 * @author yuyuexing
 * @date: 2025-05-08
 * @description: 主播电话和工会设置页面
 */

class Baixing_SetAnchorPhoneScene extends StatefulWidget {
  const Baixing_SetAnchorPhoneScene({super.key});

  @override
  State<Baixing_SetAnchorPhoneScene> createState() =>
      _Baixing_SetAnchorPhoneSceneState();
}

class _Baixing_SetAnchorPhoneSceneState
    extends State<Baixing_SetAnchorPhoneScene>
    with SingleTickerProviderStateMixin {
  final TextEditingController _mBaixing_nameController =
      TextEditingController();
  final TextEditingController _mBaixing_guildController =
      TextEditingController();
  bool _mBaixing_isAgree = true;

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
    _mBaixing_guildController.dispose();
    _mBaixing_animationController.dispose();
    super.dispose();
  }

  void _baixing_submitAuth() {
    if (_mBaixing_nameController.text.isEmpty) {
      Baixing_Toast.show("请输入手机号码");
      return;
    }
    if (!_mBaixing_isAgree) {
      Baixing_Toast.show("请阅读并同意主播管理协议");
      _mBaixing_animationCount = 5;
      _mBaixing_animationController.forward();
      Baixing_Vibrate.vibrate();
      return;
    }
    Baixing_Toast.show("申请成功");
    Navigator.of(context).pop();
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
          title: Text("主播入驻"),
          centerTitle: true,
        ),
        body: Builder(
          builder: (scaffoldContext) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Text(
                      "为了方便后续您提供持续性的服务，开播前需要您提供一些基本信息\n\n\n以下内容后续如需修改请联系客服",
                      style: textTheme.labelMedium,
                    ),
                    SizedBox(height: 20.h),
                    Text("联系电话", style: textTheme.titleSmall),
                    SizedBox(height: 10.h),
                    CupertinoTextField(
                      maxLength: 11,
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 14.sp),
                      placeholder: "请输入手机号码",
                      controller: _mBaixing_nameController,
                    ),
                    SizedBox(height: 20.h),
                    Text("公会", style: textTheme.titleSmall),
                    SizedBox(height: 5.h),
                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        CupertinoTextField(
                          style: TextStyle(fontSize: 14.sp),
                          placeholder: "请选择公会（经纪人）",
                          controller: _mBaixing_guildController,
                        ),
                        IconButton(
                          onPressed: () {
                            baixing_showGuildListDialog(context, (string) {
                              _mBaixing_guildController.text = string;
                            });
                          },
                          icon: Icon(Icons.keyboard_arrow_down_sharp),
                        ),
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
            );
          },
        ),
      ),
    );
  }
}
