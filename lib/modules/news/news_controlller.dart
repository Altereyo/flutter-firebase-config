import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_firebase_config/data/models/news.dart';
import 'package:flutter_firebase_config/modules/news/opened_news_screen.dart';
import 'package:flutter_firebase_config/modules/webview/webview_screen.dart';
import 'package:get/get.dart';

class NewsController extends GetxController {
  final RxList<News> newsList = RxList([]);
  final RxBool newsLoaded = RxBool(false);

  @override
  Future<void> onInit() async {
    newsList.value = await getNews();
    super.onInit();
  }

  Future<List<News>> getNews() async {
    // simulating request
    return Future.delayed(const Duration(seconds: 2), () async {
      final String response = await rootBundle.loadString('assets/news_response.json');
      final List data = await json.decode(response);
      newsLoaded.value = true;
      return data.map((el) => News.fromMap(el)).toList();
    });
  }

  void onNewsTapped(News tappedEl) {
    Get.to(OpenedNewsScreen(tappedEl));
  }

  void onNewsBackTapped() {
    Get.back();
  }

  void onAboutTapped () {
    // example link for exact news
    Get.to(() => WebViewScreen('https://google.com'), arguments: {
      'allow_exit': true,
    });
  }
}