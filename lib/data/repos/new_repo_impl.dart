import 'package:news_app_bloc/core/api/api_client.dart';
import 'package:news_app_bloc/data/models/news_model.dart';
import 'package:news_app_bloc/domain/repos/news_repo.dart';

class NewsRepositoryImpl implements NewsRepository {
  @override
  Future<Result<List<NewsModel>>> fetchAll() async {
    return await ApiClient.call<List<NewsModel>>(
      endpoint: "/top-headlines",
      queryParameters: {
        "country": "us",
        "category": "business",
        "apiKey": "4366941d42f84ce4a251ae00d0c66a75",
      },
      parser: (json) => parseList(json["articles"], NewsModel.fromJson),
    );
  }
}
