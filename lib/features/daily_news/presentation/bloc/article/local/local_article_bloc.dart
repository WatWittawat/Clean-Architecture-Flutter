import 'package:clean_arch/features/daily_news/domain/usecases/get_saved_article.dart';
import 'package:clean_arch/features/daily_news/domain/usecases/delete_article.dart';
import 'package:clean_arch/features/daily_news/domain/usecases/saved_article.dart';
import 'package:clean_arch/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:clean_arch/features/daily_news/presentation/bloc/article/local/local_article_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LocalArticleBloc extends Bloc<LocalArticleEvent, LocalArticleState> {
  final GetSavedArticle getSavedArticles;
  final DeleteArticle deleteArticle;
  final SavedArticle saveArticle;

  LocalArticleBloc({
    required this.getSavedArticles,
    required this.deleteArticle,
    required this.saveArticle,
  }) : super(const LocalArticleLoading()) {
    on<GetSavedArticlesEvent>(onGetSavedArticles);
    on<DeleteArticleEvent>(onDeleteArticle);
    on<SaveArticleEvent>(onSaveArticle);
  }

  void onGetSavedArticles(
    GetSavedArticlesEvent event,
    Emitter<LocalArticleState> emit,
  ) async {
    emit(const LocalArticleLoading());
    final articles = await getSavedArticles();
    emit(LocalArticleLoaded(articles: articles));
  }

  void onDeleteArticle(
      DeleteArticleEvent event, Emitter<LocalArticleState> emit) async {
    emit(const LocalArticleLoading());
    await deleteArticle(params: event.id);
    final articles = await getSavedArticles();
    emit(LocalArticleLoaded(articles: articles));
  }

  void onSaveArticle(
      SaveArticleEvent event, Emitter<LocalArticleState> emit) async {
    emit(const LocalArticleLoading());
    await saveArticle(params: event.article);
    final articles = await getSavedArticles();
    emit(LocalArticleLoaded(articles: articles));
  }
}
