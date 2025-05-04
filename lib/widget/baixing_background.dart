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
}