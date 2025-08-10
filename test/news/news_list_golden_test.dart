import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:news_app_bloc/data/models/news_model.dart';
import 'package:news_app_bloc/presentation/news/widgets/news_card.dart';
import 'package:news_app_bloc/presentation/news/widgets/news_list_view.dart';

void main() {
  testGoldens('NewsCard golden test', (tester) async {
    final widget = NewsCard(
      data: NewsModel(
        title: 'Breaking News',
        description: 'This is a description of the breaking news.',
        url: '',
      ),
    );

    await tester.pumpWidgetBuilder(widget);
    await screenMatchesGolden(tester, 'news_card');
  });

  testGoldens('NewsListView loaded state golden', (tester) async {
    await tester.pumpWidgetBuilder(
      NewsListView(
        newsList: [
          NewsModel(
            title: 'Sample News 1',
            description: 'Description 1',
            url: '',
          ),
          NewsModel(
            title: 'Sample News 2',
            description: 'Description 2',
            url: '',
          ),
          NewsModel(
            title: 'Sample News 3',
            description: 'Description 3',
            url: '',
          ),
        ],
      ),
      wrapper: materialAppWrapper(),
    );

    await screenMatchesGolden(tester, 'news_list_view_loaded');
  });
}
