import 'package:flutter/material.dart';
import 'package:flutter_firebase_config/modules/webview/webview_controller.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class WebViewScreen extends GetView<WebViewController> {
  final String url;

  const WebViewScreen(this.url, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () => controller.onBackPressed(),
          child: Column(
            children: [
              Expanded(
                child: Stack(children: [
                  InAppWebView(
                    initialUrlRequest: URLRequest(url: Uri.parse(url)),
                    initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                        useShouldOverrideUrlLoading: true,
                        javaScriptCanOpenWindowsAutomatically: true,
                      ),
                    ),
                    onWebViewCreated: controller.onWebViewCreated,
                    androidOnPermissionRequest:
                        controller.androidOnPermissionRequest,
                    onProgressChanged: controller.onProgressChanged,
                  ),
                  Obx(
                    () => controller.loadProgress.value < 1.0
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Color.fromARGB(255, 32, 7, 225),
                              ),
                            )
                          : Container(),
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
