import 'package:bloc/bloc.dart';
import 'package:clean_arch/features/daily_news/domain/entities/article.dart';
import 'package:clean_arch/features/daily_news/domain/usecases/get_article.dart';
import 'package:clean_arch/global/resources/app_failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'remote_article_event.dart';
part 'remote_article_state.dart';
part 'remote_article_bloc.freezed.dart';

@injectable
class RemoteArticleBloc extends Bloc<RemoteArticleEvent, RemoteArticleState> {
  final GetArticleUseCase _getArticleUseCase;
  RemoteArticleBloc(
    this._getArticleUseCase,
  ) : super(const RemoteArticleState.loading()) {
    on<RemoteArticleEvent>(
      (event, emit) async {
        await event.map(
          getArticles: (event) async {
            return _getArticles(
              event,
              emit,
            );
          },
        );
      },
    );
  }

  Future _getArticles(
    _GetArticles event,
    Emitter<RemoteArticleState> emit,
  ) async {
    emit(const RemoteArticleState.loading());

    final result = await _getArticleUseCase();

    result.fold(
      (l) => emit(RemoteArticleState.error(l)),
      (r) => emit(
        RemoteArticleState.done(r),
      ),
    );
  }
}
