import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../src/web_view_stack.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
// dawedat373@touchend.com
    controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://dashboard.siapjadiasn.com/'),
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
    return Stack(
      children: [
        FutureBuilder(
          future: Future.value(true),
          // future: Future.delayed(const Duration(seconds: 2), () => true),
          builder: (BuildContext context, AsyncSnapshot<void> snap) {
            //If we do not have data as we wait for the future to complete,
            //show any widget, eg. empty Container
            if (!snap.hasData) {
              return Container();
            }

            //Otherwise the future completed, so we can now safely use the controller.page
            return WillPopScope(
              onWillPop: _onBackPressed,
              child: Scaffold(
                appBar: AppBar(toolbarHeight: 0),
                body: WebViewStack(controller: controller),
              ),
            );
          },
        ),
        // WillPopScope(
        //   onWillPop: _onBackPressed,
        //   child: Scaffold(
        //     appBar: AppBar(toolbarHeight: 0),
        //     body: WebViewStack(controller: controller),
        //   ),
        // ),
      ],
    );
  }
}
