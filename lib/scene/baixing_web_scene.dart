import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Baixing_WebScene extends StatelessWidget {
  final String _TAG = 'yyx Baixing_WebScene';
  final String url;

  const Baixing_WebScene({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    print(_TAG + 'build 方法被调用');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(url),
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
                ..loadRequest(Uri.parse(url)),
        ),
      ),
    );
  }
}
