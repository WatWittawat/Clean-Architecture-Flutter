import 'package:clean_arch/features/daily_news/data/models/article_model.dart';
import 'package:clean_arch/features/daily_news/domain/repository/article_repository.dart';
import 'package:clean_arch/global/usecases/usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class SavedArticle implements Usecase<void, ArticleModel> {
  final ArticleRepository _articleRepository;

  SavedArticle(this._articleRepository);
  @override
  Future<void> call({ArticleModel? params}) async {
    return _articleRepository.saveArticle(params!);
  }
}
