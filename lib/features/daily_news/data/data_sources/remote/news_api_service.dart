import 'package:clean_arch/features/daily_news/domain/entities/article.dart';
import 'package:clean_arch/global/constants/api_endpoints.dart';
import 'package:clean_arch/global/constants/article_param_constant.dart';
import 'package:clean_arch/global/remote/network_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

@injectable
class NewsApiService {
  final NetworkService _networkService;

  NewsApiService(this._networkService);

  static Map<String, dynamic> queryParam = {
    "apiKey": dotenv.env["NEWSAPIKEY"],
    "country": ArticleParamConstant.country,
    "category": ArticleParamConstant.category
  };

  Future<List<Article>> getNewsArticles() async {
    try {
      final response = await _networkService.get(
          ApiEndpoints.urlNews, null, queryParam, null);
      final articles = response.data['articles'] as List;
      return articles.map((e) => Article.fromJson(e)).toList();
    } catch (_) {
      rethrow;
    }
  }
}
