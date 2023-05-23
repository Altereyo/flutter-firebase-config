import 'package:flutter/material.dart';
import 'package:flutter_firebase_config/core/theme/app_colors.dart';
import 'package:flutter_firebase_config/modules/news/news_controlller.dart';
import 'package:get/get.dart';

class NewsScreen extends GetView<NewsController> {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hot sport news'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            children: controller.newsList.map((el) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: GestureDetector(
                  onTap: () => controller.onNewsTapped(el),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.containerColor,
                    ),
                    child: Center(
                      child: ListTile(
                        leading: SizedBox(
                          width: 110,
                          height: 90,
                          child: Placeholder(
                            color: AppColors.accentColor,
                          ),
                        ),
                        title: Text(
                          el.title!,
                          style: TextStyle(color: AppColors.accentColor),
                        ),
                        subtitle: Text(
                          el.description!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                          style: TextStyle(color: AppColors.textColor),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
