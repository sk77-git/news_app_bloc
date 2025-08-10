import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app_bloc/data/models/news_model.dart';
import 'package:news_app_bloc/presentation/news/widgets/news_card.dart';

class NewsListView extends StatelessWidget {
  final List<NewsModel> newsList;

  const NewsListView({super.key, required this.newsList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: newsList.length,
      itemBuilder: (context, index) {
        final news = newsList[index];
        return InkWell(
          onTap: () {
            context.push('/detail', extra: news.url);
          },
          child: NewsCard(data: news),
        );
      },
    );
  }
}
