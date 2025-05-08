import 'dart:io';
import 'dart:math';

import 'package:baixinglive/compat/baixing_toast.dart';
import 'package:baixinglive/compat/baixing_vibrate.dart';
import 'package:baixinglive/entity/baixing_account_entity.dart';
import 'package:baixinglive/provider/baixing_account_model.dart';
import 'package:baixinglive/provider/baixing_login_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class Baixing_LoginScene extends StatefulWidget {
  const Baixing_LoginScene({super.key});

  @override
  State<Baixing_LoginScene> createState() => _Baixing_LoginSceneState();
}

class _Baixing_LoginSceneState extends State<Baixing_LoginScene>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  bool _baixing_isAgree = false;
  final TextEditingController _baixing_phoneNumberController =
      TextEditingController();
  final TextEditingController _baixing_codeController = TextEditingController();
  final Debouncer _baixing_debouncer = Debouncer();
  late AnimationController _controller;
  late Animation<double> _animation;
  var _animationCount = 5;
  var _height = 230.w;
  ScrollController? _scrollController = ScrollController();
  bool? _move = false;

  void baixing_login(Baixing_LoginModel baixing_loginModel) async {
    if (!_baixing_ischeck()) return;
    var result = await baixing_loginModel.baixing_login(
      phoneNumber: _baixing_phoneNumberController.text,
      code: _baixing_codeController.text,
    );
    if (result) {
      final account = Baixing_AccountEntity(phone: _baixing_phoneNumberController.text)
        ..token = baixing_loginModel.baixing_netin_userToken
        ..mBaixing_nickName = "尊敬的用户${Random().nextInt(100)}"
        ..mBaixing_level = 4
        ..mBaixing_avatarUrl = "https://picsum.photos/200/200?random=${Random().nextInt(1000)}"
        ..mBaixing_id = "00014314132555"
        ..mBaixing_levelTimeoutHit = "2027-01-01"
        ..mBaixing_levelUpdateHit = "保级成功！距离白银还需充值80.0元";
      context.read<Baixing_AccountModel>().baixing_current_account = account;
      Baixing_Toast.show("登录成功");
      GoRouter.of(context).go("/home");
    } else {
      Baixing_Toast.show("登录失败");
    }
  }

  void baixing_sendCode(Baixing_LoginModel baixing_loginModel) async {
    if (!_baixing_ischeck()) return;
    if (_baixing_validatePhone()) {
      var result = await baixing_loginModel.baixing_sendCode(
        phoneNumber: _baixing_phoneNumberController.text,
      );
      if (result) {
        Baixing_Toast.show("验证码已发送");
      } else {
        Baixing_Toast.show("验证码发送失败");
      }
    } else {
      Baixing_Toast.show("请输入正确的手机号");
    }
  }

  bool _baixing_validatePhone() {
    var phone = _baixing_phoneNumberController.text;
    if (phone.length == 11) {
      final RegExp mobileRegex = RegExp(r'^1[3-9]\d{9}$');
      return mobileRegex.hasMatch(phone);
    }
    return false;
  }

  bool _baixing_ischeck() {
    if (_baixing_isAgree) {
      return true;
    } else {
      _animationCount = 20;
      _controller.forward();
      Baixing_Vibrate.vibrate();
      Baixing_Toast.showCenter("请同意用户协议");
    }
    return false;
  }

  @override
  void initState() {
    super.initState();

    final binding = WidgetsFlutterBinding.ensureInitialized();
    binding.addObserver(this);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
      if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
      if (_animationCount < 0) {
        _controller.animateTo(0);
        _controller.stop();
      }
      _animationCount--;
    });
    _animation = Tween(begin: 5.0, end: -5.0).animate(_controller);
  }

  @override
  void didChangeMetrics() {
    final bottomInset = View.of(context).viewInsets.bottom;
    setState(() {
      if(!mounted) return;
      _height = max(230.w - bottomInset, 10.w);
      if(bottomInset > 0 && _move == false) {
        _move = true;
        Future.delayed(Duration(milliseconds: 300), () {
          if(!mounted) return;
          _scrollController?.animateTo(80.w, duration: Duration(milliseconds: 500), curve: Curves.linear);
        });
        Future.delayed(Duration(milliseconds: 1000), () {
          if(!mounted) return;
          if(_move == true) {
            _move = false;
          }
        });
      }
      if (bottomInset == 0) {
        _scrollController?.jumpTo(0);
      }
    });
    super.didChangeMetrics();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _scrollController = null;
    _move = null;
    WidgetsFlutterBinding.ensureInitialized().removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    var loginModel = Provider.of<Baixing_LoginModel>(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) {
          print('返回操作已执行');
        } else {
          Baixing_Toast.show("请用home键切后台");
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          controller: _scrollController,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: EdgeInsets.only(right: 10.w, top: 30.w),
                  child: TextButton(
                    onPressed: () {},
                    child: Text("联系客服", style: TextStyle(color: Colors.black, fontSize: 14.sp),),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Container(
                      width: 158.w,
                      height: 50.w,
                      margin: EdgeInsets.only(top: 120.w),
                      child: Image.asset("images/baixing_99zhibo_text.webp"),
                    ),
                    Container(
                      width: 300.w,
                      height: 50.w,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25.w),
                        border: Border.all(color: Color(0xffECECEC), width: 1.w),
                      ),
                      margin: EdgeInsets.only(top: 60.w),
                      child: Row(
                        children: [
                          Text(
                            "+86",
                            style: TextStyle(
                              color: Color(0xff999999),
                              fontSize: 14.sp,
                            ),
                          ),
                          Icon(Icons.arrow_drop_down, color: Color(0xff999999)),
                          Container(
                            width: 1.w,
                            height: 30.w,
                            color: Color(0xffD8D8D8),
                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                          ),
                          Expanded(
                            child: CupertinoTextField(
                              controller: _baixing_phoneNumberController,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                              cursorColor: Colors.black,
                              placeholder: "请输入手机号",
                              placeholderStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.sp,
                              ),
                              maxLength: 11,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(11),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 300.w,
                      height: 50.w,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25.w),
                        border: Border.all(color: Color(0xffECECEC), width: 1.w),
                      ),
                      margin: EdgeInsets.only(top: 10.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: CupertinoTextField(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                              controller: _baixing_codeController,
                              cursorColor: Colors.black,
                              placeholder: "请输入验证码",
                              placeholderStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.sp,
                              ),
                              maxLength: 6,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(6),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                          ),
                          Container(
                            width: 1.w,
                            height: 30.w,
                            color: Color(0xffD8D8D8),
                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                          ),
                          GestureDetector(
                            onTap: () {
                              _baixing_debouncer.debounce(
                                duration: const Duration(milliseconds: 500),
                                onDebounce: () => baixing_sendCode(loginModel),
                              );
                            },
                            child: Text(
                              loginModel.baixing_out_code_button_text,
                              style: TextStyle(
                                color: Color(0xff999999),
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 300.w,
                      height: 40.w,
                      margin: EdgeInsets.only(top: 20.w),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Color(0xFFBA68FA), Color(0xFF7854F2)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white.withValues(alpha: 0.6),
                      ),
                      child: TextButton(
                        onPressed: () {
                          _baixing_debouncer.debounce(
                            duration: const Duration(microseconds: 500),
                            onDebounce: () {
                              baixing_login(loginModel);
                            },
                          );
                        },
                        child: Text(
                          "登录",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 1.w, height: _height),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: SizedBox(
                          width: 40.w,
                          height: 40.w,
                          child: Image.asset("images/baixing_weixin.webp"),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: SizedBox(
                          width: 40.w,
                          height: 40.w,
                          child: Image.asset("images/baixing_qq.webp"),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: SizedBox(
                          width: 40.w,
                          height: 40.w,
                          child: Image.asset("images/baixing_99.webp"),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: SizedBox(
                          width: 40.w,
                          height: 40.w,
                          child: Image.asset("images/baixing_weibo.webp"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(_animation.value, 0),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 30.w, top: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CupertinoCheckbox(
                              value: _baixing_isAgree,
                              onChanged: (value) {
                                setState(() {
                                  _baixing_isAgree = value ?? false;
                                });
                              },
                            ),
                            Text(
                              "已阅读并同意",
                              style: TextStyle(
                                color: Color(0xff999999),
                                fontSize: 10.sp,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                GoRouter.of(
                                  context,
                                ).push("/web?url=https://www.163.com");
                              },
                              child: Text(
                                '《用户协议》',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ),
                            Text(
                              "和",
                              style: TextStyle(
                                color: Color(0xff999999),
                                fontSize: 10.sp,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                GoRouter.of(
                                  context,
                                ).push("/web?url=https://www.233.tv");
                              },
                              child: Text(
                                '《隐私政策》',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 10.sp,
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
            ],
          ),
        ),
      ),
    );
  }
}
