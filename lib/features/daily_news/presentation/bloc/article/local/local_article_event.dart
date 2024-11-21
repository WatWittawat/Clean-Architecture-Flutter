import 'package:clean_arch/features/daily_news/data/models/article_model.dart';
import 'package:equatable/equatable.dart';

abstract class LocalArticleEvent extends Equatable {
  final ArticleModel? article;
  final String? id;

  const LocalArticleEvent({this.article, this.id});

  @override
  List<Object?> get props => [article];
}

class GetSavedArticlesEvent extends LocalArticleEvent {
  const GetSavedArticlesEvent();
}

class SaveArticleEvent extends LocalArticleEvent {
  const SaveArticleEvent({required ArticleModel article})
      : super(article: article);
}

class DeleteArticleEvent extends LocalArticleEvent {
  const DeleteArticleEvent({required String id}) : super(id: id);
}
