import 'package:news_app_bloc/core/api/api_client.dart';
import 'package:news_app_bloc/data/models/news_model.dart';
import 'package:news_app_bloc/data/repos/new_repo_impl.dart';

class FetchAllNews {
  Future<Result<List<NewsModel>>> execute() => NewsRepositoryImpl().fetchAll();
}
