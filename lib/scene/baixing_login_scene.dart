import 'dart:io';

import 'package:baixinglive/business/net/baixing_net_core_work.dart';
import 'package:baixinglive/provider/baixing_login.dart';
import 'package:baixinglive/widget/Baixing_login_agreement_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Baixing_LoginScene extends StatefulWidget {
  const Baixing_LoginScene({super.key});

  @override
  State<Baixing_LoginScene> createState() => _Baixing_LoginSceneState();
}

class _Baixing_LoginSceneState extends State<Baixing_LoginScene>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> _baixing_loginFormKey = GlobalKey<FormState>();
  bool _baixing_isAgree = false;
  final TextEditingController _baixing_phoneNumberController =
      TextEditingController();
  final TextEditingController _baixing_codeController = TextEditingController();
  final Debouncer _baixing_debouncer = Debouncer();
  late AnimationController _controller;
  late Animation<double> _animation;
  var _animationCount = 5;

  void baixing_login(Baixing_LoginModel baixing_loginModel) async {
    if(!_baixing_ischeck()) return;
    var state = _baixing_loginFormKey.currentState;
    if (state != null && state.validate()) {
      var result = await baixing_loginModel.baixing_login(
        phoneNumber: _baixing_phoneNumberController.text,
        code: _baixing_codeController.text,
      );
      if (result) {
        Fluttertoast.showToast(msg: "登录成功");
      } else {
        Fluttertoast.showToast(msg: "登录失败");
      }
    }
  }

  void baixing_sendCode(Baixing_LoginModel baixing_loginModel) async {
    if(!_baixing_ischeck()) return;
    if(_baixing_validatePhone()) {
      var result = await baixing_loginModel.baixing_sendCode(phoneNumber: _baixing_phoneNumberController.text);
      if (result) {
        Fluttertoast.showToast(msg: "验证码已发送");
      } else {
        Fluttertoast.showToast(msg: "验证码发送失败");
      }
    } else {
      Fluttertoast.showToast(msg: "请输入正确的手机号");
    }
  }

  bool _baixing_validatePhone() {
    var phone = _baixing_phoneNumberController.text;
    if (phone.length == 11) {
      final RegExp mobileRegex = RegExp(
        r'^1[3-9]\d{9}$',
      );
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
      Fluttertoast.showToast(msg: "请同意用户协议", gravity: ToastGravity.CENTER);
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
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
      if(_animationCount < 0) {
        _controller.animateTo(0);
        _controller.stop();
      }
      _animationCount--;
    });
    _animation = Tween(
      begin: 5.0,
      end: -5.0,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var loginModel = Provider.of<Baixing_LoginModel>(context);
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: EdgeInsets.only(right: 10.w, top: 30.w),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "联系客服",
                  style: TextStyle(color: Color(0xff999999), fontSize: 14.sp),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 32.w, vertical: 80.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (Platform.isAndroid || Platform.isIOS) {
                        Fluttertoast.showToast(
                          msg: "This is Center Short Toast",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Color(0x88000000),
                          textColor: Colors.white,
                          fontSize: 16.sp,
                        );
                      }
                    },
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
            child: Form(
              key: _baixing_loginFormKey,
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
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "请输入手机号",
                              hintStyle: TextStyle(
                                color: Color(0xff999999),
                                fontSize: 14.sp,
                              ),
                            ),
                            validator: (value) {
                              if (value?.isNotEmpty == true &&
                                  value?.length == 11) {
                                return null;
                              }
                              return "请输入正确的手机号";
                            },
                            controller: _baixing_phoneNumberController,
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
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "请输入验证码",
                              hintStyle: TextStyle(
                                color: Color(0xff999999),
                                fontSize: 14.sp,
                              ),
                            ),
                            validator: (value) {
                              if (value?.isNotEmpty == true &&
                                  value?.length == 6) {
                                return null;
                              }
                              return "请输入正确的验证码";
                            },
                            controller: _baixing_codeController,
                          ),
                        ),
                        Container(
                          width: 1.w,
                          height: 30.w,
                          color: Color(0xffD8D8D8),
                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                        ),
                        TextButton(
                          onPressed: () {
                            _baixing_debouncer.debounce(
                                duration: const Duration(milliseconds:500),
                                onDebounce: () => baixing_sendCode(loginModel)
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
                            }
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
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(_animation.value, 0),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20.w),
                      width: 320.w,
                      child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        value: _baixing_isAgree,
                        onChanged: (value) {
                          setState(() {
                            _baixing_isAgree = value ?? false;
                          });
                        },
                        title: BaixingLoginAgressmentText(),
                      ),
                    ),
                  );
                }
            ),
          ),
        ],
      ),
    );
  }
}
