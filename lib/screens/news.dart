import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_config/data/models/news.dart';
import 'package:flutter_firebase_config/screens/opened_news.dart';
import 'package:flutter_firebase_config/styles/app_colors.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final List<News> newsList = List.generate(12, (idx) {
    return News(
      title: 'News title ${idx + 1}',
      description:
          'Description of news ${idx+1}: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec aliquet nunc et purus malesuada porttitor. Pellentesque iaculis, dolor vel consequat sagittis, velit elit congue nisl, quis scelerisque leo lorem ut ipsum. In at tempor tortor, et ullamcorper elit. Integer in tortor sed arcu tincidunt pretium id id magna. Curabitur mollis, arcu at molestie fermentum, nulla lacus eleifend risus, a tincidunt neque magna vitae purus. Suspendisse arcu nulla, venenatis nec tellus vel, faucibus commodo quam. Cras quis molestie urna. Integer viverra luctus eros et molestie. Curabitur pretium purus auctor efficitur venenatis. Pellentesque vulputate ex sed elit sodales, at feugiat nisl facilisis.',
    );
  });

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
            children: newsList.map((el) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OpenedNewsScreen(el),
                      ),
                    );
                  },
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
