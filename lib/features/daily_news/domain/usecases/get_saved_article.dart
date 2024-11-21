import 'package:clean_arch/features/daily_news/data/models/article_model.dart';
import 'package:clean_arch/features/daily_news/domain/repository/article_repository.dart';
import 'package:clean_arch/global/usecases/usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetSavedArticle implements Usecase<List<ArticleModel>, void> {
  final ArticleRepository _articleRepository;

  GetSavedArticle(this._articleRepository);
  @override
  Future<List<ArticleModel>> call({params}) async {
    return _articleRepository.getSavedArticles();
  }
}
