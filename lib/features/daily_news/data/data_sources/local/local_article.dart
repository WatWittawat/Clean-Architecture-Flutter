import 'package:clean_arch/features/daily_news/data/models/article_model.dart';
import 'package:clean_arch/global/database/hive/hive_operation.dart';

abstract class LocalArticle {
  Future<List<ArticleModel>> getSavedArticles();

  Future<void> saveArticle(ArticleModel article);

  Future<void> deleteArticle(String id);
}

class LocalArticleImpl implements LocalArticle {
  final HiveOperation<ArticleModel> _hiveOperation;

  LocalArticleImpl(this._hiveOperation);

  @override
  Future<List<ArticleModel>> getSavedArticles() async {
    return await _hiveOperation.getAllItems();
  }

  @override
  Future<void> saveArticle(ArticleModel article) async {
    return await _hiveOperation.insertOrUpdateItem(
      article.publishedAt,
      article,
    );
  }

  @override
  Future<void> deleteArticle(String id) async {
    return await _hiveOperation.deleteItem(id);
  }
}
