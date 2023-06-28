import 'package:check_vpn_connection/check_vpn_connection.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_firebase_config/data/services/firebase_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'functions.dart';

Future<String> getRelevantRoute() async {
  final SharedPreferences storage = await SharedPreferences.getInstance();
  final FirebaseService firebaseService = Get.find<FirebaseService>();

  final String? savedLink = storage.getString('webview_link');
  final bool internetConnected = await checkConnection();
  final bool isEmulator = await checkIsEmu();
  final bool linkSaved = savedLink != null && savedLink.isNotEmpty;


  if (linkSaved) {
    return internetConnected
        ? '/webview'
        : '/connection_error';
  }

  if (!firebaseService.connected) await firebaseService.connect();

  try {
    final FirebaseRemoteConfig? remoteConfig = await firebaseService.getRemoteConfig();
    String webviewLink = remoteConfig!.getString('url');
    bool needToCheckVpn = remoteConfig!.getBool('to');

    if (true && await CheckVpnConnection.isVpnActive()) {
      return '/plug';
    }

    if (webviewLink == '' || isEmulator) {
      return '/plug';
    } else {
      storage.setString('webview_link', webviewLink);
      return '/webview';
    }
  } catch (err) {
    return '/connection_error';
  }
}