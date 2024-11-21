import 'package:clean_arch/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:clean_arch/features/daily_news/presentation/bloc/article/local/local_article_state.dart';
import 'package:clean_arch/features/daily_news/presentation/widget/local_article_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorite',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: BlocBuilder<LocalArticleBloc, LocalArticleState>(
        builder: (context, state) {
          if (state is LocalArticleLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LocalArticleLoaded) {
            return state.articles!.isNotEmpty
                ? ListView.builder(
                    itemCount:
                        state.articles != null ? state.articles!.length : 0,
                    itemBuilder: (context, index) {
                      return LocalArticleTile(article: state.articles![index]);
                    },
                  )
                : const Center(
                    child: Text("ไม่มีข่าวที่ชื่นชอบ"),
                  );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
