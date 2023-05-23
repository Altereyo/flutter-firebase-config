import 'package:flutter_firebase_config/data/services/connection_service.dart';
import 'package:flutter_firebase_config/data/services/firebase_service.dart';
import 'package:flutter_firebase_config/modules/connection_error/connection_error.dart';
import 'package:flutter_firebase_config/modules/news/news_controlller.dart';
import 'package:flutter_firebase_config/modules/news/news_screen.dart';
import 'package:flutter_firebase_config/modules/webview/webview_controller.dart';
import 'package:flutter_firebase_config/modules/webview/webview_screen.dart';
import 'package:flutter_firebase_config/core/functions/functions.dart';
import 'package:flutter_firebase_config/core/theme/theme_data.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initServices();

  final String defaultRoute = await getRelevantRoute();
  final SharedPreferences storage = await SharedPreferences.getInstance();
  final String? webviewLink = storage.getString('webview_link');

  runApp(
    GetMaterialApp(
      title: 'Flutter App',
      theme: themeData,
      initialRoute: defaultRoute,
      onReady: () => Get.find<ConnectionService>().initConnectionListener(),
      getPages: [
        GetPage(
          name: '/webview',
          page: () => WebViewScreen(webviewLink!),
          binding: BindingsBuilder(() => Get.lazyPut<WebViewController>(() => WebViewController()))
        ),
        GetPage(
          name: '/news',
          page: () => const NewsScreen(),
          binding: BindingsBuilder(() => Get.lazyPut<NewsController>(() => NewsController()))
        ),
        GetPage(
          name: '/connection_error',
          page: () => const ConnectionErrorScreen(),
        ),
      ]
    ),
  );
}

Future<void> initServices() async {
  Get.lazyPut(() => FirebaseService());
  Get.lazyPut(() => ConnectionService());
}
