import 'package:fpdart/fpdart.dart';

import 'package:clean_arch/features/daily_news/domain/entities/article.dart';
import 'package:clean_arch/features/daily_news/domain/repository/article_repository.dart';
import 'package:clean_arch/global/resources/app_failure.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  @override
  Future<Either<AppFailure, List<Article>>> getArticles() {
    // TODO: implement getArticles
    throw UnimplementedError();
  }
}
