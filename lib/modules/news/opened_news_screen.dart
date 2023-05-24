import 'package:flutter/material.dart';
import 'package:flutter_firebase_config/data/models/news.dart';
import 'package:flutter_firebase_config/core/theme/app_colors.dart';
import 'package:flutter_firebase_config/modules/news/news_controlller.dart';
import 'package:get/get.dart';

class OpenedNewsScreen extends StatelessWidget {
  OpenedNewsScreen(this.newsObj, {Key? key}) : super(key: key);
  final News newsObj;
  final NewsController controller = Get.find<NewsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(newsObj.title!),
        leading: GestureDetector(
          onTap: controller.onNewsBackTapped,
          child: Center(
            child: Icon(
              Icons.arrow_back_ios,
              color: AppColors.textColor,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.network(
                      newsObj.imageUrl!,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      newsObj.description!,
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: GestureDetector(
                onTap: controller.onAboutTapped,
                child: RichText(
                  text: const TextSpan(
                    text: 'Read more about this article on ',
                    style: TextStyle(fontSize: 12),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'example-url.com',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
