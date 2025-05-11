import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Baixing_LocalWebScene extends StatelessWidget {
  final String _TAG = 'yyx Baixing_WebScene';
  final String mBaixing_title;
  final String mBaixing_htmlCode;

  const Baixing_LocalWebScene({super.key, required this.mBaixing_title, required this.mBaixing_htmlCode});

  @override
  Widget build(BuildContext context) {
    print(_TAG + 'build 方法被调用');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(mBaixing_title),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: WebViewWidget(
          controller:
              WebViewController()
                ..setJavaScriptMode(JavaScriptMode.unrestricted)
                ..loadHtmlString(mBaixing_htmlCode),
        ),
      ),
    );
  }
}
