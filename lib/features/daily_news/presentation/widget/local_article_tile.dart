import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_arch/features/daily_news/data/models/article_model.dart';
import 'package:clean_arch/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:clean_arch/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:clean_arch/global/constants/app_routes.dart';
import 'package:clean_arch/global/generated/fonts.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LocalArticleTile extends StatelessWidget {
  const LocalArticleTile({super.key, required this.article});

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(
          AppRoutes.articleDetailRoute,
          extra: {
            "article": article,
          },
        );
      },
      child: Container(
        padding: const EdgeInsetsDirectional.only(
          start: 14,
          end: 14,
          bottom: 14,
        ),
        height: MediaQuery.of(context).size.height / 4,
        child: Row(
          children: [
            _buildImage(context),
            _buildContent(context),
            IconButton(
              onPressed: () {
                context.read<LocalArticleBloc>().add(
                      DeleteArticleEvent(id: article.publishedAt),
                    );
              },
              icon: const Icon(
                Icons.delete_forever_sharp,
                size: 30,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: article.urlToImage ?? "",
      imageBuilder: (context, imageProvider) => Padding(
        padding: const EdgeInsetsDirectional.only(end: 14.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: double.maxFinite,
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
      progressIndicatorBuilder: (context, url, progress) => Padding(
        padding: const EdgeInsetsDirectional.only(end: 14.0),
        child: Container(
          width: MediaQuery.of(context).size.width / 3,
          height: double.maxFinite,
          child: const CupertinoActivityIndicator(),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.08),
          ),
        ),
      ),
      errorWidget: (context, url, error) => Padding(
        padding: const EdgeInsetsDirectional.only(end: 14.0),
        child: Container(
          width: MediaQuery.of(context).size.width / 3,
          height: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.08),
          ),
          child: const Icon(Icons.error),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.title ?? "",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: FontFamily.ibmPlexSansThai,
                fontWeight: FontWeight.w900,
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  article.description ?? "",
                  maxLines: 2,
                ),
              ),
            ),
            Row(
              children: [
                const Icon(Icons.timeline_outlined, size: 16),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  article.publishedAt,
                  style: const TextStyle(
                    fontSize: 9,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
