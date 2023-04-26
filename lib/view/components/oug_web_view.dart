import 'dart:async';

import 'package:flutter/material.dart';
import 'package:outugo_flutter_mobile/shared/themes/app_theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OUGWebView extends StatefulWidget {
  final String url;
  final bool showBack;
  final String navTitle;

  OUGWebView({
    required this.url,
    this.showBack = false,
    this.navTitle = '',
  });

  @override
  _OUGWebViewState createState() => _OUGWebViewState();
}

class _OUGWebViewState extends State<OUGWebView> {
  final WebViewController _controller = WebViewController();
  final Completer<WebViewController> _completer =
      Completer<WebViewController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel('Toaster',
          onMessageReceived: (onMessageReceived) {})
      ..loadRequest(Uri.parse(widget.url))
          .whenComplete(() => _completer.complete(_controller));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: (widget.showBack)
          ? AppBar(
              title: Text(
                (widget.navTitle != null && widget.navTitle.length > 0)
                    ? widget.navTitle
                    : 'Visit Report',
                style: TextStyle(color: AppTheme.black),
              ),
              backgroundColor: AppTheme.black,
              iconTheme: IconThemeData(
                color: AppTheme.black,
              ),
            )
          : null,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 44),
              child: WebViewWidget(
                controller: _controller,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      spreadRadius: 0,
                      blurRadius: 1,
                      offset: Offset(0, -2), // changes position of shadow
                    ),
                  ],
                ),
                child: FutureBuilder<WebViewController>(
                    future: _completer.future,
                    builder: (BuildContext context,
                        AsyncSnapshot<WebViewController> snapshot) {
                      final bool webViewReady =
                          snapshot.connectionState == ConnectionState.done;
                      final WebViewController webViewController =
                          snapshot.data!;
                      return Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            icon: const Icon(
                              Icons.arrow_back_ios_outlined,
                              color: Colors.blue,
                            ),
                            onPressed: !webViewReady
                                ? null
                                : () async {
                                    if (await webViewController.canGoBack()) {
                                      await webViewController.goBack();
                                    } else {
                                      return;
                                    }
                                  },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            icon: const Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.blue,
                            ),
                            onPressed: !webViewReady
                                ? null
                                : () async {
                                    if (await webViewController
                                        .canGoForward()) {
                                      await webViewController.goForward();
                                    } else {
                                      return;
                                    }
                                  },
                          ),
                          Spacer(),
                          IconButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            icon: const Icon(
                              Icons.replay,
                              color: Colors.blue,
                            ),
                            onPressed: !webViewReady
                                ? null
                                : () {
                                    webViewController.reload();
                                  },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
