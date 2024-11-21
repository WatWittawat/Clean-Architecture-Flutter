import 'package:clean_arch/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:clean_arch/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:clean_arch/global/config/injectable.dart';
import 'package:clean_arch/global/database/hive/hive_manager.dart';
import 'package:clean_arch/global/route/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'global/theme/app_theme.dart';

void main() async {
  configureDependencies();
  await dotenv.load(fileName: ".env");
  getIt<HiveManager>().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: AppRouter.router.routerDelegate,
      routeInformationParser: AppRouter.router.routeInformationParser,
      routeInformationProvider: AppRouter.router.routeInformationProvider,
      theme: theme(),
      debugShowCheckedModeBanner: false,
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider<LocalArticleBloc>(
            create: (context) => getIt()
              ..add(
                const GetSavedArticlesEvent(),
              ),
          ),
        ],
        child: child!,
      ),
    );
  }
}
