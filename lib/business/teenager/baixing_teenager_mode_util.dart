import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:baixinglive/scene/baixing_teenager_content_scene.dart';

/**
* @author yuyuexing
* @date: 2025-05-06
* @description: 青少年模式工具类，用于检查和管理青少年模式状态
*/
class Baixing_TeenagerModeUtil {
  // 私有构造函数
  Baixing_TeenagerModeUtil._();

  // 单例实例
  static final Baixing_TeenagerModeUtil _instance = Baixing_TeenagerModeUtil._();

  // 获取单例实例
  static Baixing_TeenagerModeUtil get instance => _instance;

  // 检查是否处于青少年模式
  Future<bool> baixing_isTeenagerModeEnabled() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("teenager_mode_enabled") ?? false;
  }

  // 检查青少年模式并在需要时跳转到青少年模式页面
  Future<bool> baixing_checkAndRedirectIfNeeded(BuildContext context) async {
    final bool isEnabled = await baixing_isTeenagerModeEnabled();
    
    if (isEnabled) {
      // 检查当前时间是否在允许使用的时间范围内（6:00-22:00）
      final now = DateTime.now();
      final hour = now.hour;
      
      if (hour >= 22 || hour < 6) {
        // 在禁止使用时间段内
        _baixing_showTimeRestrictedDialog(context);
        return true;
      }
      
      // 跳转到青少年模式内容页面
      final result = await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Baixing_TeenagerContentScene(),
        ),
      );
      
      // 如果从青少年模式退出，返回false表示不再处于青少年模式
      return result != true;
    }
    
    return false;
  }

  // 重置每日使用时间（在新的一天开始时调用）
  Future<void> baixing_resetDailyUsageTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("teenager_mode_used_time", 0);
  }

  // 显示时间限制对话框
  void _baixing_showTimeRestrictedDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CupertinoAlertDialog(
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
}