import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class WebViewController extends GetxController {
  late InAppWebViewController _webViewController;
  RxDouble loadProgress = RxDouble(0);

  void onWebViewCreated(InAppWebViewController controller) {
    _webViewController = controller;
  }

  Future<bool> onBackPressed() async {
    _webViewController.goBack();
    // argument which may be passed when page was opening
    // we can exit webview if we opened it from onAboutTapped function
    return Get.arguments['allow_exit'] ?? false;
  }

  Future<PermissionRequestResponse> androidOnPermissionRequest(InAppWebViewController controller, String origin, List<String> resources) async {
    return PermissionRequestResponse(
      resources: resources,
      action: PermissionRequestResponseAction.GRANT,
    );
  }

  void onProgressChanged(controller, progress) {
    loadProgress.value = progress / 100;
  }
}
