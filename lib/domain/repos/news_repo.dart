import 'package:news_app_bloc/core/api/api_client.dart';
import 'package:news_app_bloc/data/models/news_model.dart';

abstract class NewsRepository {
  Future<Result<List<NewsModel>>> fetchAll();
}
