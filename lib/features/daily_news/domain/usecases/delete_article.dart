import 'package:clean_arch/features/daily_news/domain/repository/article_repository.dart';
import 'package:clean_arch/global/usecases/usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteArticle implements Usecase<void, String> {
  final ArticleRepository _articleRepository;

  DeleteArticle(this._articleRepository);
  @override
  Future<void> call({String? params}) async {
    return _articleRepository.deleteArticle(params!);
  }
}
