import 'package:clean_arch/features/daily_news/data/data_sources/local/local_article.dart';
import 'package:clean_arch/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:clean_arch/features/daily_news/data/models/article_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:clean_arch/features/daily_news/domain/entities/article.dart';
import 'package:clean_arch/features/daily_news/domain/repository/article_repository.dart';
import 'package:clean_arch/global/resources/app_failure.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ArticleRepository)
class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService;
  final LocalArticle _localArticle;

  ArticleRepositoryImpl(this._newsApiService, this._localArticle);
  @override
  Future<Either<AppFailure, List<Article>>> getArticles() async {
    try {
      final data = await _newsApiService.getNewsArticles();
      return Right(data);
    } on Exception catch (e) {
      return Left(AppFailure.fromException(e));
    }
  }

  @override
  Future<List<ArticleModel>> getSavedArticles() async {
    return await _localArticle.getSavedArticles();
  }

  @override
  Future<void> saveArticle(ArticleModel article) async {
    return await _localArticle.saveArticle(article);
  }

  @override
  Future<void> deleteArticle(String id) async {
    return await _localArticle.deleteArticle(id);
  }
}
