part of 'remote_article_bloc.dart';

@freezed
class RemoteArticleState with _$RemoteArticleState {
  const factory RemoteArticleState.loading() = _Loading;
  const factory RemoteArticleState.done(List<Article> articles) = _Done;
  const factory RemoteArticleState.error(AppFailure failure) = _Error;
}
