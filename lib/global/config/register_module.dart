import 'package:clean_arch/features/daily_news/data/data_sources/local/local_article.dart';
import 'package:clean_arch/features/daily_news/data/models/article_model.dart';
import 'package:clean_arch/global/database/hive/hive_operation.dart';
import 'package:clean_arch/global/database/primitive/primitive_database.dart';
import 'package:clean_arch/global/database/secure/secure_storage_manager.dart';
import 'package:clean_arch/global/remote/app_dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RegisterModule {
  @singleton
  HiveInterface get hive => Hive;

  @lazySingleton
  Dio get dio => AppDio.getInstance();

  @Injectable(as: PrimitiveDatabase)
  SecureStorageManager get secureStorageManager => SecureStorageManager(
        const FlutterSecureStorage(),
      );

  @lazySingleton
  HiveOperation<ArticleModel> get articleOperation =>
      HiveOperation<ArticleModel>(hive, secureStorageManager);

  @lazySingleton
  LocalArticle get localArticle => LocalArticleImpl(articleOperation);
}
