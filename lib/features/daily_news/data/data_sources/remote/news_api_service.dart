import 'package:clean_arch/features/daily_news/data/models/article_model.dart';
import 'package:clean_arch/global/constants/api_endpoints.dart';
import 'package:clean_arch/global/constants/article_param_constant.dart';
import 'package:clean_arch/global/remote/network_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NewsApiService {
  final NetworkService _networkService;

  NewsApiService(this._networkService);

  static Map<String, dynamic> queryParam = {
    "apiKey": dotenv.env["NEWSAPIKEY"],
    "country": ArticleParamConstant.country,
    "category": ArticleParamConstant.category
  };

  Future<void> getNewsArticles() async {
    final data =
        await _networkService.get(ApiEndpoints.urlNews, null, queryParam, null);
    print(data);
  }
}
