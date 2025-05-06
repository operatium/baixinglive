import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Baixing_BackGround {

  static BoxDecoration baixing_getCircle() {
    return BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: Colors.black, width: 1),
    );
  }

  // 圆角 矩形 描边
  static BoxDecoration baixing_getRoundedRectangularOutLine({
    double radius = 20,
    Color borderColor = Colors.black,
    double borderWidth = 1,
  }) {
    return BoxDecoration(
      color: Colors.transparent,
      // 设置圆角
      borderRadius: BorderRadius.circular(radius),
      // 设置描边
      border: Border.all(
        color: borderColor,
        width: borderWidth,
      ),
    );
  }

  //圆角 矩形 白色实体
  static BoxDecoration baixing_getRoundedRectangular({
    required double radius,
    Color color = Colors.white,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    );
  }

  //不规则圆角 矩形 实体 竖直方向3色渐变
  static BoxDecoration baixing_getRoundedRectangular_K001() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFFDFA275),
          Color(0xFFECD1BC),
          Color(0xFFCE875B),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [
          0,
          0.5,
          1,
        ],
      ),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(60),
        bottomLeft: Radius.circular(16),
        bottomRight: Radius.circular(16),
      ),
    );
  }

  //圆角 矩形 实体 水平方向2色渐变
  static BoxDecoration baixing_getRoundedRectangular_K002() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF7F64F0),
          Color(0xFFD984E9),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        stops: [
          0,
          1,
        ],
      ),
      borderRadius: BorderRadius.all(Radius.circular(16)),
    );
  }
}