part of 'remote_article_bloc.dart';

@freezed
class RemoteArticleEvent with _$RemoteArticleEvent {
  const factory RemoteArticleEvent.getArticles() = _GetArticles;
}
