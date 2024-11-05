import 'package:clean_arch/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:fpdart/fpdart.dart';

import 'package:clean_arch/features/daily_news/domain/entities/article.dart';
import 'package:clean_arch/features/daily_news/domain/repository/article_repository.dart';
import 'package:clean_arch/global/resources/app_failure.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ArticleRepository)
class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService;

  ArticleRepositoryImpl(this._newsApiService);
  @override
  Future<Either<AppFailure, List<Article>>> getArticles() async {
    try {
      final data = await _newsApiService.getNewsArticles();
      return Right(data);
    } on Exception catch (e) {
      return Left(AppFailure.fromException(e));
    }
  }
}
