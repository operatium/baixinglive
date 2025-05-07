import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Baixing_MessageDialog extends StatelessWidget {

  const Baixing_MessageDialog({
    Key? key,
    required this.mbaixing_title,
    required this.mbaixing_message,
    required this.mbaixing_buttonText,
    required this.mbaixing_onPressed,
  }) : super(key: key);

  final String mbaixing_title;
  final String mbaixing_message;
  final String mbaixing_buttonText;
  final VoidCallback mbaixing_onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(mbaixing_title),
      content: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.h),
        child: Text(
          mbaixing_message,
          textAlign: TextAlign.start,
        ),
      ),
      actions: [
        TextButton(
          onPressed: mbaixing_onPressed,
          child: Text(
            mbaixing_buttonText,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ],
    );
  }
}