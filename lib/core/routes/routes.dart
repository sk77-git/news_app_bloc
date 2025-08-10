// router.dart
import 'package:go_router/go_router.dart';
import 'package:news_app_bloc/presentation/news/pages/news_detail_page.dart';
import 'package:news_app_bloc/presentation/news/pages/news_list_page.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const NewsListPage()),
    GoRoute(
      path: '/detail',
      builder: (context, state) {
        final url = state.extra as String;
        return NewsDetailPage(url: url);
      },
    ),
  ],
);
