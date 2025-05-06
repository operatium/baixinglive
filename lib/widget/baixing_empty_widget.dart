import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Baixing_EmptyWidget extends StatefulWidget {
  FutureOr<void> Function(String) mBaixing_onPress;
  Widget Function(BuildContext) mBaixing_contentLayoutBuild;
  Baixing_EmptyControl mBaixing_emptyControl;

  Baixing_EmptyWidget({
    Key? key,
    required this.mBaixing_onPress,
    required this.mBaixing_contentLayoutBuild,
    required this.mBaixing_emptyControl,
  }):super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Baixing_EmptyWidgetState();
  }
}

class _Baixing_EmptyWidgetState extends State<Baixing_EmptyWidget> {

  @override
  void initState() {
    super.initState();
    widget.mBaixing_emptyControl.addListener(_update);
  }

  @override
  void dispose() {
    super.dispose();
    widget.mBaixing_emptyControl.removeListener(_update);
  }

  void _update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final control = widget.mBaixing_emptyControl;
    return LayoutBuilder(
      builder: (context, mConstraintType) {
        return Stack(
          children: [
            Visibility(
              visible: control._mBaixing_isLoading,
              child: Center(child: CircularProgressIndicator(value: null)),
            ),
            Visibility(
              visible: !control._mBaixing_isLoading && control._mBaixing_isContentLayout,
              child: widget.mBaixing_contentLayoutBuild(context),
            ),
            Visibility(
              visible: !control._mBaixing_isLoading && control._mBaixing_isError,
              child: _baixing_getHitPage("请求失败", "重试"),
            ),
            Visibility(
              visible: !control._mBaixing_isLoading && control._mBaixing_isEmpty,
              child: _baixing_getHitPage("没有内容", "刷新"),
            ),
          ],
        );
      },
    );
  }

  Widget _baixing_getHitPage(String message, String button) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("images/baixing_99.webp"),
          Text(message),
          ElevatedButton(
            onPressed: () {
              widget.mBaixing_onPress(button);
            },
            child: Text(button),
          ),
        ],
      ),
    );
  }
}

class Baixing_EmptyControl extends ChangeNotifier{
  bool _mBaixing_isLoading = true;
  bool _mBaixing_isEmpty = false;
  bool _mBaixing_isError = false;
  bool _mBaixing_isContentLayout = false;

  void baixing_changeState({
    bool isLoading = false,
    bool isError = false,
    bool isEmpty = false,
    bool isContentLayout = false,
  }) {
    _mBaixing_isLoading = isLoading;
    _mBaixing_isError = isError;
    _mBaixing_isEmpty = isEmpty;
    _mBaixing_isContentLayout = isContentLayout;
    notifyListeners();
  }
}
