import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_bloc/presentation/news/blocs/news_bloc.dart';

class NewsListPage extends StatelessWidget {
  const NewsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewsBloc()..add(FetchNewsEvent()),
      child: Scaffold(
        appBar: AppBar(title: Text("News List")),
        body: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NewsLoaded) {
              return ListView.builder(
                itemCount: state.newsList.length,
                itemBuilder: (context, index) {
                  final news = state.newsList[index];
                  return ListTile(
                    title: Text(news.title),
                    subtitle: Text(news.description),
                  );
                },
              );
            } else if (state is NewsError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const Center(child: Text('No data available.'));
            }
          },
        ),
      ),
    );
  }
}
