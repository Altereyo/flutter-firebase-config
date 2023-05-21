import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final bool allowExit;

  const WebViewScreen({Key? key, required this.url, this.allowExit = false}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late InAppWebViewController _webViewController;

  double progress = 0;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> onBackPressed() async {
    _webViewController.goBack();
    return widget.allowExit;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WillPopScope(
          onWillPop: onBackPressed,
          child: Column(
            children: [
              Expanded(
                child: Stack(children: [
                  InAppWebView(
                    initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
                    initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                        useShouldOverrideUrlLoading: true,
                        javaScriptCanOpenWindowsAutomatically: true,
                      ),
                    ),
                    onWebViewCreated: (controller) {
                      _webViewController = controller;
                    },
                    androidOnPermissionRequest:
                        (InAppWebViewController controller, String origin,
                            List<String> resources) async {
                      return PermissionRequestResponse(
                          resources: resources,
                          action: PermissionRequestResponseAction.GRANT);
                    },
                    onProgressChanged: (controller, progress) {
                      setState(() {
                        this.progress = progress / 100;
                      });
                    },
                  ),
                  progress < 1.0
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 32, 7, 225),
                          ),
                        )
                      : Container(),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
