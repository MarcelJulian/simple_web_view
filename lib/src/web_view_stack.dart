import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:simple_web_view/src/pull_to_refresh.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewStack extends StatefulWidget {
  const WebViewStack({required this.controller, super.key});
  final WebViewController controller;

  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  var loadingPercentage = 0;
  late DragGesturePullToRefresh dragGesturePullToRefresh;

  @override
  void initState() {
    super.initState();

    dragGesturePullToRefresh = DragGesturePullToRefresh();

    widget.controller.setNavigationDelegate(NavigationDelegate(
      onPageStarted: (url) {
        dragGesturePullToRefresh.started();
        setState(() {
          loadingPercentage = 0;
        });
      },
      onProgress: (progress) {
        setState(() {
          loadingPercentage = progress;
        });
      },
      onPageFinished: (url) {
        dragGesturePullToRefresh.finished();
        setState(() {
          loadingPercentage = 100;
        });
      },
    )
        // ..loadRequest(
        //   Uri.parse('https://dashboard.siapjadiasn.com/'),
        // )
        // ..setJavaScriptMode(JavaScriptMode.unrestricted);
        );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: () => dragGesturePullToRefresh.refresh(),
          child: Builder(builder: (contextRefresh) {
            dragGesturePullToRefresh
                .setContext(contextRefresh)
                .setController(widget.controller);

            return WebViewWidget(
              controller: widget.controller,
              gestureRecognizers: {Factory(() => dragGesturePullToRefresh)},
              // gestureRecognizers: Set()
              //   ..add(
              //     Factory<VerticalDragGestureRecognizer>(
              //         () => VerticalDragGestureRecognizer()
              //           ..onDown = (DragDownDetails dragDownDetails) {
              //             widget.controller.getScrollPosition().then((value) {
              //               if (value.dy == 0 &&
              //                   dragDownDetails.globalPosition.direction < 1) {
              //                 widget.controller.reload();
              //               }
              //             });
              //           }),
              //   )
            );
          }),
        ),
        if (loadingPercentage < 100)
          LinearProgressIndicator(
            value: loadingPercentage / 100.0,
          ),
      ],
    );
  }
}
