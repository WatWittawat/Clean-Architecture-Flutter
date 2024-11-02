import 'package:clean_arch/features/daily_news/domain/entities/article.dart';
import 'package:clean_arch/global/resources/app_failure.dart';
import 'package:fpdart/fpdart.dart';

abstract class ArticleRepository {
  Future<Either<AppFailure, List<Article>>> getArticles();
}
