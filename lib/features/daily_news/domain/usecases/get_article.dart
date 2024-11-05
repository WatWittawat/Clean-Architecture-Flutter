import 'package:clean_arch/features/daily_news/domain/entities/article.dart';
import 'package:clean_arch/features/daily_news/domain/repository/article_repository.dart';
import 'package:clean_arch/global/resources/app_failure.dart';
import 'package:clean_arch/global/usecases/usecase.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetArticleUseCase
    implements Usecase<Either<AppFailure, List<Article>>, void> {
  final ArticleRepository _articleRepository;

  GetArticleUseCase(this._articleRepository);

  @override
  Future<Either<AppFailure, List<Article>>> call({void params}) async {
    return _articleRepository.getArticles();
  }
}
