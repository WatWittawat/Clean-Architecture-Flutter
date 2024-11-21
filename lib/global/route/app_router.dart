import 'package:clean_arch/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:clean_arch/features/daily_news/presentation/pages/daily_news/daily_news.dart';
import 'package:clean_arch/features/daily_news/presentation/pages/detail_news/detail_news.dart';
import 'package:clean_arch/features/daily_news/presentation/pages/favorite/favorite.dart';
import 'package:clean_arch/global/config/injectable.dart';
import 'package:clean_arch/global/constants/app_routes.dart';
import 'package:clean_arch/global/widget/scaffold_with_nav_bar.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigationKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

class AppRouter {
  AppRouter._();

  static final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigationKey,
    initialLocation: AppRoutes.root,
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            ScaffoldWithNavBar(navigationShell: navigationShell),
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.root,
                name: AppRoutes.dailyNewsScreenName,
                pageBuilder: (context, state) => getSlideTransitionPage(
                  context: context,
                  state: state,
                  page: BlocProvider<RemoteArticleBloc>(
                    create: (context) =>
                        getIt()..add(const RemoteArticleEvent.getArticles()),
                    child: const DailyNews(),
                  ),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.favoriteRoute,
                name: AppRoutes.favoriteScreenName,
                pageBuilder: (context, state) => getSlideTransitionPage(
                  context: context,
                  state: state,
                  page: const Favorite(),
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.articleDetailRoute,
        name: AppRoutes.articleDetailScreenName,
        pageBuilder: (context, state) {
          final article = (state.extra as Map<String, dynamic>)['article']!;
          return getSlideTransitionPage(
            context: context,
            state: state,
            page: DetailNews(
              article: article,
            ),
          );
        },
      ),
    ],
  );

  static CustomTransitionPage getSlideTransitionPage({
    required BuildContext context,
    required GoRouterState state,
    required Widget page,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
        child: child,
      ),
    );
  }

  static GoRouter get router => _router;
}
