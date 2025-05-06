import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

/**
* @author yuyuexing
* @date: 2025-05-07
* @description: 设置青少年模式监护密码的对话框
*/
class Baixing_SetEnterTeenagerModePasswordDialog extends StatefulWidget {
  const Baixing_SetEnterTeenagerModePasswordDialog({super.key});

  @override
  State<StatefulWidget> createState() => _Baixing_SetEnterTeenagerModePasswordDialogState();
}

class _Baixing_SetEnterTeenagerModePasswordDialogState extends State<Baixing_SetEnterTeenagerModePasswordDialog> {
  // 密码输入控制器
  final TextEditingController _mBaixing_passwordController1 = TextEditingController();
  final TextEditingController _mBaixing_passwordController2 = TextEditingController();
  
  // 是否显示错误提示
  bool _mBaixing_showError = false;
  
  // 错误提示文本
  String _mBaixing_errorText = '';

  @override
  void dispose() {
    _mBaixing_passwordController1.dispose();
    _mBaixing_passwordController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Container(
        width: 320.w,
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 标题
            Text(
              "设置监护密码",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15.h),
            
            // 密码说明
            Text(
              "请设置6位数字监护密码，用于解除青少年模式限制",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp, color: Colors.black54),
            ),
            SizedBox(height: 20.h),
            
            // 第一个密码输入框
            _baixing_buildPasswordInput(
              _mBaixing_passwordController1,
              "请输入密码",
              false,
            ),
            SizedBox(height: 15.h),
            
            // 第二个密码输入框
            _baixing_buildPasswordInput(
              _mBaixing_passwordController2,
              "请输入密码",
              true,
            ),
            
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
                    Navigator.of(context).pop();
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
                    style: TextStyle(
                      color: Color(0xff8955F7),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 构建密码输入框
  Widget _baixing_buildPasswordInput(TextEditingController controller, String hintText, bool isLastInput) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!, width: 1.0),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        obscureText: true,
        textAlign: TextAlign.start,
        maxLength: 6,
        decoration: InputDecoration(
          counterText: "",
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey[300]),
          contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
        ),
        style: TextStyle(fontSize: 16.sp),
        onEditingComplete: () {
          if (isLastInput) {
            // 最后一个输入框输入完成，收起键盘
            FocusScope.of(context).unfocus();
          }
        },
      ),
    );
  }

  // 处理提交
  void _baixing_handleSubmit() async {
    // 获取输入的密码
    String password1 = _mBaixing_passwordController1.text;
    String password2 = _mBaixing_passwordController2.text;
    
    // 验证密码
    if (password1.isEmpty || password2.isEmpty) {
      setState(() {
        _mBaixing_showError = true;
        _mBaixing_errorText = "请输入密码";
      });
      return;
    }
    
    // 验证密码是否为6位数字
    if (!RegExp(r'^\d{6}$').hasMatch(password1)) {
      setState(() {
        _mBaixing_showError = true;
        _mBaixing_errorText = "请输入6位数字密码";
      });
      return;
    }
    
    // 验证两次密码是否一致
    if (password1 != password2) {
      setState(() {
        _mBaixing_showError = true;
        _mBaixing_errorText = "两次输入的密码不一致";
      });
      return;
    }
    
    // 保存密码并启用青少年模式
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("teenager_mode_password", password1);
    await prefs.setBool("teenager_mode_enabled", true);
    await prefs.setInt("teenager_mode_start_time", DateTime.now().millisecondsSinceEpoch);
    
    if (!mounted) return;
    
    // 返回true表示成功设置密码并开启青少年模式
    Navigator.of(context).pop(true);
  }
}

// 显示设置青少年模式密码对话框的辅助方法
Future<bool?> baixing_showSetTeenagerModePasswordDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => const Baixing_SetEnterTeenagerModePasswordDialog(),
  );
}