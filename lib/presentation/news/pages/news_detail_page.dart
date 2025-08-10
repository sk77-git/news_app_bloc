import 'package:flutter/material.dart';
import 'package:news_app_bloc/presentation/widgets/app_web_view.dart';

class NewsDetailPage extends StatelessWidget {
  const NewsDetailPage({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("News Detail")),
      body: AppWebView(url: url),
    );
  }
}
