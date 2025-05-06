import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

/**
* @author yuyuexing
* @date: 2025-05-06
* @description: 青少年模式设置和验证页面
*/
class Baixing_TeenagerModeScene extends StatefulWidget {
  final bool isVerifying; // 是否是验证模式（退出青少年模式时验证密码）
  final bool isInfoPage; // 是否是信息展示页面

  const Baixing_TeenagerModeScene({super.key, this.isVerifying = false, this.isInfoPage = false});

  @override
  State<StatefulWidget> createState() => _Baixing_TeenagerModeSceneState();
}

class _Baixing_TeenagerModeSceneState extends State<Baixing_TeenagerModeScene> {
  // 密码输入框控制器
  final List<TextEditingController> _mBaixing_controllers = List.generate(
      6, (index) => TextEditingController());

  // 密码输入框焦点
  final List<FocusNode> _mBaixing_focusNodes = List.generate(
      6, (index) => FocusNode());

  // 是否显示错误提示
  bool _mBaixing_showError = false;

  // 错误提示文本
  String _mBaixing_errorText = '';

  @override
  void initState() {
    super.initState();
    // 设置第一个输入框获取焦点
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_mBaixing_focusNodes.isNotEmpty) {
        _mBaixing_focusNodes[0].requestFocus();
      }
    });
  }

  @override
  void dispose() {
    // 释放控制器和焦点
    for (var controller in _mBaixing_controllers) {
      controller.dispose();
    }
    for (var node in _mBaixing_focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
        title: Text(widget.isVerifying ? "退出青少年模式" : "青少年模式"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: widget.isInfoPage
            ? _baixing_buildInfoPage()
            : Stack(
          children: [
            // 背景（保留原有背景和雨伞图标）
            _baixing_buildBackgroundWithIcon(),
            // 密码设置弹窗
            Center(
              child: _baixing_buildPasswordDialog(),
            ),
          ],
        ),
      ),
    );
  }

  // 构建信息展示页面
  Widget _baixing_buildInfoPage() {
    return Column(
      children: [
        // 顶部图标
        Padding(
          padding: EdgeInsets.only(top: 30.h, bottom: 20.h),
          child: Container(
            width: 100.w,
            height: 100.w,
            decoration: BoxDecoration(
              color: Color(0xFFE6E0FF),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(
                'images/baixing_umbrella.png',
                width: 60.w,
                height: 60.w,
              ),
            ),
          ),
        ),

        // 内容限制说明
        _baixing_buildInfoItem(
          "观看内容限制",
          "在青少年模式中，我们精选了一批适合青少年观看的优质内容；",
        ),

        // 功能限制说明
        _baixing_buildInfoItem(
          "使用功能限制",
          "无法进行充值打赏、购买、弹幕评论、视频直播等操作；",
        ),

        // 时间限制说明
        _baixing_buildInfoItem(
          "使用时间限制",
          "开启青少年模式后，每日22时至6时将无法使用；单日累计使用时长超过40分钟，需要输入监护密码才能继续使用。",
        ),

        // 底部按钮
        Expanded(child: SizedBox()),
        Padding(
          padding: EdgeInsets.only(bottom: 40.h, left: 30.w, right: 30.w),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  context.push('/teenager');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff8955F7),
                  minimumSize: Size(double.infinity, 50.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                ),
                child: Text(
                  "开启青少年模式",
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "每次开启青少年模式都需要设置密码",
                style: TextStyle(fontSize: 12.sp, color: Colors.black54),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 构建信息项
  Widget _baixing_buildInfoItem(String title, String content) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 5.h, right: 10.w),
            width: 10.w,
            height: 10.w,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5.h),
                Text(
                  content,
                  style: TextStyle(fontSize: 14.sp, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 构建背景和雨伞图标
  Widget _baixing_buildBackgroundWithIcon() {
    return Column(
      children: [
        // 顶部图标
        Padding(
          padding: EdgeInsets.only(top: 30.h, bottom: 20.h),
          child: Container(
            width: 100.w,
            height: 100.w,
            decoration: BoxDecoration(
              color: Color(0xFFE6E0FF),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(
                'images/baixing_umbrella.png',
                width: 60.w,
                height: 60.w,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 构建密码设置弹窗
  Widget _baixing_buildPasswordDialog() {
    return Container(
      width: 320.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 弹窗标题
            Text(
              widget.isVerifying ? "设置监护密码" : "设置监护密码",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15.h),
            // 密码说明
            Text(
              widget.isVerifying
                  ? "请输入6位数字监护密码，用于解除青少年模式限制"
                  : "请设置6位数字监护密码，用于解除青少年模式限制",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp, color: Colors.black54),
            ),
            SizedBox(height: 25.h),
            // 密码输入区域
            _baixing_buildPasswordInputs(),
            // 错误提示
            if (_mBaixing_showError)
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Text(
                  _mBaixing_errorText,
                  style: TextStyle(color: Colors.red, fontSize: 14.sp),
                ),
              ),
            SizedBox(height: 15.h),
            // 提示文本
            Text(
              "提示：密码仅用于解除青少年模式限制，请妥善保管",
              style: TextStyle(fontSize: 12.sp, color: Colors.black54),
            ),
            SizedBox(height: 25.h),
            // 底部按钮区域
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // 取消按钮
                TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: Text(
                    "取消",
                    style: TextStyle(color: Colors.black54, fontSize: 16.sp),
                  ),
                ),
                SizedBox(width: 20.w),
                // 确定按钮
                TextButton(
                  onPressed: _baixing_handleSubmit,
                  child: Text(
                    "确定",
                    style: TextStyle(color: Color(0xff8955F7),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 构建密码输入区域
  Widget _baixing_buildPasswordInputs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        6,
            (index) => _baixing_buildPasswordInput(index),
      ),
    );
  }

  // 构建单个密码输入框
  Widget _baixing_buildPasswordInput(int index) {
    return Container(
      width: 40.w,
      height: 50.h,
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!, width: 1.0),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: TextField(
        controller: _mBaixing_controllers[index],
        focusNode: _mBaixing_focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: "",
          border: InputBorder.none,
          hintText: "请输入密码",
          hintStyle: TextStyle(fontSize: 12.sp, color: Colors.grey[300]),
        ),
        style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        onChanged: (value) {
          if (value.isNotEmpty) {
            // 自动跳转到下一个输入框
            if (index < 5) {
              _mBaixing_focusNodes[index + 1].requestFocus();
            } else {
              // 最后一个输入框输入完成，收起键盘
              FocusScope.of(context).unfocus();
            }
          }
          // 检查是否所有输入框都已填写
          _baixing_checkAllFilled();
        },
      ),
    );
  }

  // 检查是否所有输入框都已填写
  void _baixing_checkAllFilled() {
    bool allFilled = true;
    for (var controller in _mBaixing_controllers) {
      if (controller.text.isEmpty) {
        allFilled = false;
        break;
      }
    }

    if (allFilled) {
      _baixing_handleSubmit();
    }
  }

  // 处理提交
  Future<void> _baixing_handleSubmit() async {
    // 检查是否所有输入框都已填写
    for (var controller in _mBaixing_controllers) {
      if (controller.text.isEmpty) {
        setState(() {
          _mBaixing_showError = true;
          _mBaixing_errorText = "请输入完整的6位密码";
        });
        return;
      }
    }

    // 获取输入的密码
    String password = _mBaixing_controllers.map((c) => c.text).join();

    // 验证密码是否为纯数字
    if (!RegExp(r'^\d{6}$').hasMatch(password)) {
      setState(() {
        _mBaixing_showError = true;
        _mBaixing_errorText = "请输入6位数字密码";
      });
      return;
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (widget.isVerifying) {
      // 验证模式：检查密码是否正确
      String savedPassword = prefs.getString("teenager_mode_password") ?? "";
      if (password == savedPassword) {
        // 密码正确，退出青少年模式
        await prefs.setBool("teenager_mode_enabled", false);
        if (!mounted) return;
        context.pop(true); // 返回true表示成功退出青少年模式
      } else {
        // 密码错误
        setState(() {
          _mBaixing_showError = true;
          _mBaixing_errorText = "密码错误，请重新输入";
          // 清空输入框
          for (var controller in _mBaixing_controllers) {
            controller.clear();
          }
          // 第一个输入框获取焦点
          _mBaixing_focusNodes[0].requestFocus();
        });
      }
    } else {
      // 设置模式：保存密码并启用青少年模式
      await prefs.setString("teenager_mode_password", password);
      await prefs.setBool("teenager_mode_enabled", true);
      await prefs.setInt("teenager_mode_start_time", DateTime
          .now()
          .millisecondsSinceEpoch);
      if (!mounted) return;
      context.pop(true); // 返回true表示成功开启青少年模式
    }
  }
}