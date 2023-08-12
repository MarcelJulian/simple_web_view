import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'src/web_view_stack.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const WebViewApp(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://flutter.dev'),
      )
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  Future<bool> _onBackPressed() async {
    if (await controller.canGoBack()) {
      await controller.goBack();
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(toolbarHeight: 0),
        body: WebViewStack(controller: controller),
      ),
    );
  }
}
