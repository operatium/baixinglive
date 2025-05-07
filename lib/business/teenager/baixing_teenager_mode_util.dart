import 'dart:io';

import 'package:baixinglive/compat/baixing_persistence.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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


  // 重置每日使用时间（在新的一天开始时调用）
  Future<void> baixing_resetDailyUsageTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("teenager_mode_used_time", 0);
  }


}