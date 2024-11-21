import 'package:clean_arch/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:clean_arch/features/daily_news/presentation/widget/article_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Center(
        child: _buildBody(),
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: const Text(
        'Daily News',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  _buildBody() {
    return BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
      builder: (context, state) {
        return state.map(loading: (_) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }, done: ($) {
          return ListView.builder(
            itemCount: $.articles.length,
            itemBuilder: (context, index) {
              return ArticleTile(article: $.articles[index]);
            },
          );
        }, error: (_) {
          return Center(
            child: IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                context
                    .read<RemoteArticleBloc>()
                    .add(const RemoteArticleEvent.getArticles());
              },
            ),
          );
        });
      },
    );
  }
}
