import 'package:clean_arch/features/daily_news/data/models/article_model.dart';
import 'package:equatable/equatable.dart';

abstract class LocalArticleState extends Equatable {
  final List<ArticleModel>? articles;

  const LocalArticleState({this.articles});

  @override
  List<Object> get props => [articles!];
}

class LocalArticleLoading extends LocalArticleState {
  const LocalArticleLoading();
}

class LocalArticleLoaded extends LocalArticleState {
  const LocalArticleLoaded({required List<ArticleModel> articles})
      : super(articles: articles);
}
