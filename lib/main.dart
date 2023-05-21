import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_config/core/functions/functions.dart';
import 'package:flutter_firebase_config/screens/connection_error.dart';
import 'package:flutter_firebase_config/screens/news.dart';
import 'package:flutter_firebase_config/screens/webview.dart';
import 'package:flutter_firebase_config/styles/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  String defaultRoute = '/news';
  String? webviewLink = prefs.getString('webview_link');

  bool internetConnected = await checkConnection();
  bool isEmulator = await checkIsEmu();
  bool linkSaved = webviewLink != null && webviewLink.isNotEmpty;

  if (linkSaved && internetConnected) {
    defaultRoute = '/webview';
  } else if (linkSaved && !internetConnected) {
    defaultRoute = '/connection_error';
  } else if (!linkSaved) {
    await connectFirebase();
    final FirebaseRemoteConfig remoteConfig = await getFirebaseRemoteConfig();
    String firebaseLink = remoteConfig.getString('webview_link');

    if (firebaseLink == '' || isEmulator) {
      defaultRoute = '/news';
    } else {
      webviewLink = firebaseLink;
      prefs.setString('webview_link', firebaseLink);
      defaultRoute = '/webview';
    }
  }

  runApp(
    MaterialApp(
      title: 'Flutter Firebase config',
      theme: themeData,
      initialRoute: defaultRoute,
      routes: {
        '/webview': (context) => WebViewScreen(url: webviewLink!),
        '/news': (context) => const NewsScreen(),
        '/connection_error': (_) => const ConnectionErrorScreen(),
      },
    ),
  );
}
