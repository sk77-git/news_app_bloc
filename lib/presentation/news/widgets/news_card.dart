import 'package:flutter/material.dart';
import 'package:news_app_bloc/data/models/news_model.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({super.key, required this.data});

  final NewsModel data;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(data.title, maxLines: 2, overflow: TextOverflow.ellipsis),
        subtitle: Text(
          data.description,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
