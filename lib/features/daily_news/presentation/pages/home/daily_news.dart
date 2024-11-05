import 'package:clean_arch/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
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
        }, done: (data) {
          return ListView.builder(
            itemCount: data.articles.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(data.articles[index].title ?? ""),
                subtitle: Text(data.articles[index].description ?? ""),
              );
            },
          );
        }, error: (_) {
          return const Center(
            child: Icon(Icons.refresh),
          );
        });
      },
    );
  }
}
