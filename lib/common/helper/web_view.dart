// import 'package:task_management/helper/widgets.dart';
import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String title;
  final String url;

  const WebViewPage(this.title, this.url);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController webViewC;

  @override
  void initState() {
    // webViewC = WebViewController()
    // ..setJavaScriptMode(JavaScriptMode.unrestricted)
    // ..loadRequest(Uri.parse())
    ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: Widgets.xAppBar(widget.title),
      // body: WebViewWidget(controller: webViewC),
    );
  }
}
