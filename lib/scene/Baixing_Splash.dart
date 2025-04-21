import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Baixing_SplashScene extends StatelessWidget {
  const Baixing_SplashScene({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 360.w,
        height: 640.w,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/baixing_girl_xxxl.jpg"),
            fit: BoxFit.contain,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Container(
                width: 80.w,
                height: 82.w,
                child: Image.asset("images/baixing_logo.webp"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
