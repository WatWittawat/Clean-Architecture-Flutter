import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/adapters.dart';
import '../../../../global/constants/hive_constant.dart';

part 'article_model.freezed.dart';
part 'article_model.g.dart';

@freezed
abstract class ArticleModel extends HiveObject with _$ArticleModel {
  ArticleModel._();

  @HiveType(
      typeId: HiveConstants.articleTypeId,
      adapterName: HiveConstants.articleAdapterName)
  factory ArticleModel({
    @HiveField(1) required String publishedAt,
    @HiveField(2) String? author,
    @HiveField(3) String? title,
    @HiveField(4) String? description,
    @HiveField(5) String? url,
    @HiveField(6) String? urlToImage,
    @HiveField(8) String? content,
  }) = _ArticleModel;

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);
}
