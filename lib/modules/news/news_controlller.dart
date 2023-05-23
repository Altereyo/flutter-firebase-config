import 'package:flutter_firebase_config/data/models/news.dart';
import 'package:flutter_firebase_config/modules/news/opened_news_screen.dart';
import 'package:get/get.dart';

class NewsController extends GetxController {
  final List<News> newsList = List.generate(12, (idx) {
    return News(
      title: 'News title ${idx + 1}',
      description: 'Description of news ${idx+1}: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec aliquet nunc et purus malesuada porttitor. Pellentesque iaculis, dolor vel consequat sagittis, velit elit congue nisl, quis scelerisque leo lorem ut ipsum. In at tempor tortor, et ullamcorper elit. Integer in tortor sed arcu tincidunt pretium id id magna. Curabitur mollis, arcu at molestie fermentum, nulla lacus eleifend risus, a tincidunt neque magna vitae purus. Suspendisse arcu nulla, venenatis nec tellus vel, faucibus commodo quam. Cras quis molestie urna. Integer viverra luctus eros et molestie. Curabitur pretium purus auctor efficitur venenatis. Pellentesque vulputate ex sed elit sodales, at feugiat nisl facilisis.',
    );
  });

  void onNewsTapped(News tappedEl) {
    Get.to(OpenedNewsScreen(tappedEl));
  }

  void onNewsBackTapped() {
    Get.back();
  }

  void onAboutTapped () {
    // example link for exact news
    Get.toNamed('/webview', arguments: {
      'allow_exit': true
    });
  }
}