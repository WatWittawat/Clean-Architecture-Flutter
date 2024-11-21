import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_arch/features/daily_news/data/models/article_model.dart';
import 'package:clean_arch/features/daily_news/domain/entities/article.dart';
import 'package:clean_arch/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:clean_arch/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:clean_arch/features/daily_news/presentation/bloc/article/local/local_article_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DetailNews extends StatefulWidget {
  const DetailNews({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  State<DetailNews> createState() => _DetailNewsState();
}

class _DetailNewsState extends State<DetailNews> {
  bool isFavorite = false;

  @override
  void initState() {
    context.read<LocalArticleBloc>().add(const GetSavedArticlesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.article.author ?? "No Author",
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      floatingActionButton: BlocListener<LocalArticleBloc, LocalArticleState>(
        listener: (context, state) {
          if (state is LocalArticleLoaded) {
            if (state.articles != null) {
              final List<ArticleModel> articles = state.articles!;
              bool found = false;
              for (final article in articles) {
                if (article.publishedAt == widget.article.publishedAt) {
                  found = true;
                  break;
                }
              }
              setState(() {
                isFavorite = found;
              });
            } else {
              setState(() {
                isFavorite = false;
              });
            }
          }
        },
        child: FloatingActionButton(
          onPressed: () {
            final ArticleModel article = ArticleModel(
              author: widget.article.author,
              title: widget.article.title,
              description: widget.article.description,
              url: widget.article.url,
              urlToImage: widget.article.urlToImage,
              publishedAt: widget.article.publishedAt,
              content: widget.article.content,
            );
            if (isFavorite) {
              isFavorite = false;
              context
                  .read<LocalArticleBloc>()
                  .add(DeleteArticleEvent(id: article.publishedAt));
            } else {
              isFavorite = true;
              context
                  .read<LocalArticleBloc>()
                  .add(SaveArticleEvent(article: article));
            }
          },
          child: Icon(
            isFavorite ? Icons.bookmark : Icons.bookmark_add_outlined,
            color: isFavorite ? Colors.red : Colors.black,
          ),
          backgroundColor: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              Text(
                widget.article.title ?? "No Title",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              CachedNetworkImage(
                imageUrl: widget.article.urlToImage ?? "",
                fadeInCurve: Curves.bounceIn,
                errorWidget: (context, url, error) => const Icon(Icons.error),
                imageBuilder: (context, imageProvider) => ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.08),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text("Published At: ${widget.article.publishedAt}"),
              const SizedBox(height: 10),
              Text(
                widget.article.description ?? "",
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.article.content ?? "",
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
